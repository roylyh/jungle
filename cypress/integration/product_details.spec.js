describe('Jungle product details', () => {
  beforeEach(() => {
    cy.visit('/');
    cy.get("article")
      .first()
      .click();
  });
  
  it("shows the product detail page", () => {
    cy.get(".product-detail").should("be.visible");
  });
});