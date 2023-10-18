require_relative '../../../modules/book_module'
require_relative '../../../classes/book'
require_relative '../../../classes/label'

RSpec.describe BookModule do
  before :each do
    @book = Book.new(
      publisher: 'Some Publisher',
      cover_state: 'good',
      id: 1,
      label: Label.new(1, 'Some Label', 'Red'),
      publish_date: '01-01-2021'
    )

    @label = Label.new(1, 'Some Label', 'Red')
    @books = [@book]
    @labels = [@label]
  end

  describe '.add_book' do
    before do
      allow(BookModule).to receive(:collect_attributes).and_return({
                                                                     publisher: 'New Publisher',
                                                                     cover_state: 'bad',
                                                                     label: nil,
                                                                     publish_date: '01-01-2021'
                                                                   })

      allow(BookModule).to receive(:collect_label_index).and_return(0)
    end

    it 'adds a book to the list' do
      expect { BookModule.add_book(@books, nil, nil, @labels) }.to change { @books.length }.from(1).to(2)
    end
  end
end
