describe('Jungle Home Page', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it("Load the title",() => {
    cy.get(".title").find("h1").should("have.text", "The Jungle");
  }
  );

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});