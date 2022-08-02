module Operations
  class OrderRentals
    include ::Interactor::Organizer

    organize CreateCars, CalculateRental, AddCommissions, AddOptions
  end
end