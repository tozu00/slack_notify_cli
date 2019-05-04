RSpec.describe SlackNotifyCli do
  it "has a version number" do
    expect(SlackNotifyCli::VERSION).not_to be nil
    expect(SlackNotifyCli::VERSION).to eq '0.1.0'
  end

  describe "command", type: :aruba do
    context "auth_check" do
      before(:each) { run_command('slack_notify_cli auth_check') }
      it { expect(last_command_started).to be_successfully_executed }
      it { expect(last_command_started).to have_output 'Authentication successed' }
    end

    context "channel_list" do
      before(:each) { run_command('slack_notify_cli channel_list') }
      it { expect(last_command_started).to be_successfully_executed }
    end

    context "send" do
      before(:each) { run_command('slack_notify_cli send "#test" "Hello"') }
      it { expect(last_command_started).to be_successfully_executed }
    end

  end
end
