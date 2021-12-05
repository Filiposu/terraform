package az.phonebook.backend.enums;

public enum CurrencyRateType {

    CASH("CASH"),
    NONCASH("NON-CASH"),
    STANDARD("STANDARD"),
    IB_RATE("IB_RATE"),
    IPS_RATE("IPS_RATE"),
    ALL("ALL");

    private final String currencyName;

    CurrencyRateType(String currencyName) {
        this.currencyName = currencyName;
    }

    public static CurrencyRateType getEnum(String value) {
        for (CurrencyRateType e : CurrencyRateType.values()) {
            if (e.currencyName.equalsIgnoreCase(value)) {
                return e;
            }
        }
        return null;// not found
    }

    public String getCurrencyName() {
        return currencyName;
    }

}
