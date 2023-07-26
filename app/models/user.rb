class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy

  delegate :birthday, :gender , :age , to: :profile ,allow_nil: true

  def has_written?(board)
    boards.exists?(id: board.id)
  end

  def has_added?(task)
    tasks.exists?(id: task.id)
  end

  def display_icon
    if profile&.avatar&.attached?
      profile.avatar
    else
      'Oval.svg'
    end
  end

  def birthday
    profile&.birthday
  end

  def gender
    profile&.gender
  end
  
  def display_name
    profile&.nickname || self.email.split('@').first
  end
end
