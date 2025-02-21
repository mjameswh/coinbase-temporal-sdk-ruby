require 'securerandom'

class TestSerializer
  extend Temporal::Concerns::Payloads
end

Fabricator(:api_history_event, from: Temporalio::Api::History::V1::HistoryEvent) do
  event_id { 1 }
  event_time { Time.now }
end

Fabricator(:api_workflow_execution_started_event, from: :api_history_event) do
  transient :headers
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_WORKFLOW_EXECUTION_STARTED }
  event_time { Time.now }
  workflow_execution_started_event_attributes do |attrs|
    header_fields = (attrs[:headers] || {}).each_with_object({}) do |(field, value), h|
      h[field] = Temporal.configuration.converter.to_payload(value)
    end
    header = Temporalio::Api::Common::V1::Header.new(fields: header_fields)

    Temporalio::Api::History::V1::WorkflowExecutionStartedEventAttributes.new(
      workflow_type: Fabricate(:api_workflow_type),
      task_queue: Fabricate(:api_task_queue),
      input: nil,
      workflow_execution_timeout: 60,
      workflow_task_timeout: 15,
      original_execution_run_id: SecureRandom.uuid,
      identity: 'test-worker@test-host',
      first_execution_run_id: SecureRandom.uuid,
      retry_policy: nil,
      attempt: 0,
      header: header,
    )
  end
end

Fabricator(:api_workflow_execution_completed_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_WORKFLOW_EXECUTION_COMPLETED }
  workflow_execution_completed_event_attributes do |attrs|
    Temporalio::Api::History::V1::WorkflowExecutionCompletedEventAttributes.new(
      result: nil,
      workflow_task_completed_event_id: attrs[:event_id] - 1
    )
  end
end

Fabricator(:api_workflow_task_scheduled_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_WORKFLOW_TASK_SCHEDULED }
  workflow_task_scheduled_event_attributes do |attrs|
    Temporalio::Api::History::V1::WorkflowTaskScheduledEventAttributes.new(
      task_queue: Fabricate(:api_task_queue),
      start_to_close_timeout: 15,
      attempt: 0
    )
  end
end

Fabricator(:api_workflow_task_started_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_WORKFLOW_TASK_STARTED }
  workflow_task_started_event_attributes do |attrs|
    Temporalio::Api::History::V1::WorkflowTaskStartedEventAttributes.new(
      scheduled_event_id: attrs[:event_id] - 1,
      identity: 'test-worker@test-host',
      request_id: SecureRandom.uuid
    )
  end
end

Fabricator(:api_workflow_task_completed_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_WORKFLOW_TASK_COMPLETED }
  workflow_task_completed_event_attributes do |attrs|
    Temporalio::Api::History::V1::WorkflowTaskCompletedEventAttributes.new(
      scheduled_event_id: attrs[:event_id] - 2,
      started_event_id: attrs[:event_id] - 1,
      identity: 'test-worker@test-host',
      binary_checksum: 'v1.0.0',
    )
  end
end

Fabricator(:api_activity_task_scheduled_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_ACTIVITY_TASK_SCHEDULED }
  activity_task_scheduled_event_attributes do |attrs|
    Temporalio::Api::History::V1::ActivityTaskScheduledEventAttributes.new(
      activity_id: attrs[:event_id].to_s,
      activity_type: Temporalio::Api::Common::V1::ActivityType.new(name: 'TestActivity'),
      workflow_task_completed_event_id: attrs[:event_id] - 1,
      task_queue: Fabricate(:api_task_queue)
    )
  end
end

Fabricator(:api_activity_task_started_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_ACTIVITY_TASK_STARTED }
  activity_task_started_event_attributes do |attrs|
    Temporalio::Api::History::V1::ActivityTaskStartedEventAttributes.new(
      scheduled_event_id: attrs[:event_id] - 1,
      identity: 'test-worker@test-host',
      request_id: SecureRandom.uuid
    )
  end
end

Fabricator(:api_activity_task_completed_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_ACTIVITY_TASK_COMPLETED }
  activity_task_completed_event_attributes do |attrs|
    Temporalio::Api::History::V1::ActivityTaskCompletedEventAttributes.new(
      result: nil,
      scheduled_event_id: attrs[:event_id] - 2,
      started_event_id: attrs[:event_id] - 1,
      identity: 'test-worker@test-host'
    )
  end
end

Fabricator(:api_activity_task_failed_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_ACTIVITY_TASK_FAILED }
  activity_task_failed_event_attributes do |attrs|
    Temporalio::Api::History::V1::ActivityTaskFailedEventAttributes.new(
      failure: Temporalio::Api::Failure::V1::Failure.new(message: "Activity failed"),
      scheduled_event_id: attrs[:event_id] - 2,
      started_event_id: attrs[:event_id] - 1,
      identity: 'test-worker@test-host'
    )
  end
end

Fabricator(:api_activity_task_canceled_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_ACTIVITY_TASK_CANCELED }
  activity_task_canceled_event_attributes do |attrs|
    Temporalio::Api::History::V1::ActivityTaskCanceledEventAttributes.new(
      details: TestSerializer.to_details_payloads('ACTIVITY_ID_NOT_STARTED'),
      scheduled_event_id: attrs[:event_id] - 2,
      started_event_id: nil,
      identity: 'test-worker@test-host'
    )
  end
end

Fabricator(:api_activity_task_cancel_requested_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_ACTIVITY_TASK_CANCEL_REQUESTED }
  activity_task_cancel_requested_event_attributes do |attrs|
    Temporalio::Api::History::V1::ActivityTaskCancelRequestedEventAttributes.new(
      scheduled_event_id: attrs[:event_id] - 1,
      workflow_task_completed_event_id: attrs[:event_id] - 2,
    )
  end
end

Fabricator(:api_timer_started_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_TIMER_STARTED }
  timer_started_event_attributes do |attrs|
    Temporalio::Api::History::V1::TimerStartedEventAttributes.new(
      timer_id: attrs[:event_id].to_s,
      start_to_fire_timeout: 10,
      workflow_task_completed_event_id: attrs[:event_id] - 1
    )
  end
end

Fabricator(:api_timer_fired_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_TIMER_FIRED }
  timer_fired_event_attributes do |attrs|
    Temporalio::Api::History::V1::TimerFiredEventAttributes.new(
      timer_id: attrs[:event_id].to_s,
      started_event_id: attrs[:event_id] - 4
    )
  end
end

Fabricator(:api_timer_canceled_event, from: :api_history_event) do
  event_type { Temporalio::Api::Enums::V1::EventType::EVENT_TYPE_TIMER_CANCELED }
  timer_canceled_event_attributes do |attrs|
    Temporalio::Api::History::V1::TimerCanceledEventAttributes.new(
      timer_id: attrs[:event_id].to_s,
      started_event_id: attrs[:event_id] - 4,
      workflow_task_completed_event_id: attrs[:event_id] - 1,
      identity: 'test-worker@test-host'
    )
  end
end
