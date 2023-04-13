describe("Add to cart", () => {
  beforeEach(() => {
    cy.visit("/");
  });
  it("Incriments product cart when add button is clicked", () => {
    cy.get(".products article")
      .first()
      .click();

    cy.get(".product-detail").should("be.visible");

    cy.get(".button_to")
      .click();
    cy.get(".nav-link").contains("My Cart (1)");
  });

}

);