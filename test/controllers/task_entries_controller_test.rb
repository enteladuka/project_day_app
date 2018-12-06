require 'test_helper'

class TaskEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_entry = task_entries(:one)
  end

  test "should get index" do
    get task_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_task_entry_url
    assert_response :success
  end

  test "should create task_entry" do
    assert_difference('TaskEntry.count') do
      post task_entries_url, params: { task_entry: { duration: @task_entry.duration, note: @task_entry.note, task_id: @task_entry.task_id } }
    end

    assert_redirected_to task_entry_url(TaskEntry.last)
  end

  test "should show task_entry" do
    get task_entry_url(@task_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_entry_url(@task_entry)
    assert_response :success
  end

  test "should update task_entry" do
    patch task_entry_url(@task_entry), params: { task_entry: { duration: @task_entry.duration, note: @task_entry.note, task_id: @task_entry.task_id } }
    assert_redirected_to task_entry_url(@task_entry)
  end

  test "should destroy task_entry" do
    assert_difference('TaskEntry.count', -1) do
      delete task_entry_url(@task_entry)
    end

    assert_redirected_to task_entries_url
  end
end
