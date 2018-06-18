require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    # binding.pry
    if valid? && self.status == "pending" && sender.balance >= self.amount
      receiver.balance += self.amount
      sender.balance -= self.amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if valid? && self.status == "complete" && receiver.balance >= self.amount
      sender.balance += self.amount
      receiver.balance -= self.amount
      self.status = "reversed"
    # else
    #   # self.status = "rejected"
      # "Transaction rejected. Please check your account balance."
    end
  end
end
