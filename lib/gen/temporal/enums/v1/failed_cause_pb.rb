# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: temporal/enums/v1/failed_cause.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("temporal/enums/v1/failed_cause.proto", :syntax => :proto3) do
    add_enum "temporal.enums.v1.DecisionTaskFailedCause" do
      value :DECISION_TASK_FAILED_CAUSE_UNSPECIFIED, 0
      value :DECISION_TASK_FAILED_CAUSE_UNHANDLED_DECISION, 1
      value :DECISION_TASK_FAILED_CAUSE_BAD_SCHEDULE_ACTIVITY_ATTRIBUTES, 2
      value :DECISION_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES, 3
      value :DECISION_TASK_FAILED_CAUSE_BAD_START_TIMER_ATTRIBUTES, 4
      value :DECISION_TASK_FAILED_CAUSE_BAD_CANCEL_TIMER_ATTRIBUTES, 5
      value :DECISION_TASK_FAILED_CAUSE_BAD_RECORD_MARKER_ATTRIBUTES, 6
      value :DECISION_TASK_FAILED_CAUSE_BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES, 7
      value :DECISION_TASK_FAILED_CAUSE_BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES, 8
      value :DECISION_TASK_FAILED_CAUSE_BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES, 9
      value :DECISION_TASK_FAILED_CAUSE_BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES, 10
      value :DECISION_TASK_FAILED_CAUSE_BAD_CONTINUE_AS_NEW_ATTRIBUTES, 11
      value :DECISION_TASK_FAILED_CAUSE_START_TIMER_DUPLICATE_ID, 12
      value :DECISION_TASK_FAILED_CAUSE_RESET_STICKY_TASKLIST, 13
      value :DECISION_TASK_FAILED_CAUSE_WORKFLOW_WORKER_UNHANDLED_FAILURE, 14
      value :DECISION_TASK_FAILED_CAUSE_BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES, 15
      value :DECISION_TASK_FAILED_CAUSE_BAD_START_CHILD_EXECUTION_ATTRIBUTES, 16
      value :DECISION_TASK_FAILED_CAUSE_FORCE_CLOSE_DECISION, 17
      value :DECISION_TASK_FAILED_CAUSE_FAILOVER_CLOSE_DECISION, 18
      value :DECISION_TASK_FAILED_CAUSE_BAD_SIGNAL_INPUT_SIZE, 19
      value :DECISION_TASK_FAILED_CAUSE_RESET_WORKFLOW, 20
      value :DECISION_TASK_FAILED_CAUSE_BAD_BINARY, 21
      value :DECISION_TASK_FAILED_CAUSE_SCHEDULE_ACTIVITY_DUPLICATE_ID, 22
      value :DECISION_TASK_FAILED_CAUSE_BAD_SEARCH_ATTRIBUTES, 23
    end
    add_enum "temporal.enums.v1.StartChildWorkflowExecutionFailedCause" do
      value :START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED, 0
      value :START_CHILD_WORKFLOW_EXECUTION_FAILED_CAUSE_WORKFLOW_ALREADY_EXISTS, 1
    end
    add_enum "temporal.enums.v1.CancelExternalWorkflowExecutionFailedCause" do
      value :CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED, 0
      value :CANCEL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND, 1
    end
    add_enum "temporal.enums.v1.SignalExternalWorkflowExecutionFailedCause" do
      value :SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_UNSPECIFIED, 0
      value :SIGNAL_EXTERNAL_WORKFLOW_EXECUTION_FAILED_CAUSE_EXTERNAL_WORKFLOW_EXECUTION_NOT_FOUND, 1
    end
  end
end

module Temporal
  module Proto
    module Enums
      module V1
        DecisionTaskFailedCause = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("temporal.enums.v1.DecisionTaskFailedCause").enummodule
        StartChildWorkflowExecutionFailedCause = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("temporal.enums.v1.StartChildWorkflowExecutionFailedCause").enummodule
        CancelExternalWorkflowExecutionFailedCause = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("temporal.enums.v1.CancelExternalWorkflowExecutionFailedCause").enummodule
        SignalExternalWorkflowExecutionFailedCause = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("temporal.enums.v1.SignalExternalWorkflowExecutionFailedCause").enummodule
      end
    end
  end
end