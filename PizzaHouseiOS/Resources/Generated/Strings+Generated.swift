// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Pizza House
  internal static let pizzaHouse = L10n.tr("Localizable", "PizzaHouse")

  internal enum Cart {
    /// Корзина
    internal static let cart = L10n.tr("Localizable", "Cart.Cart")
  }

  internal enum Menu {
    /// В корзину
    internal static let cartButton = L10n.tr("Localizable", "Menu.CartButton")
    /// Меню
    internal static let menu = L10n.tr("Localizable", "Menu.Menu")
  }

  internal enum Onboarding {
    internal enum Delivery {
      /// Совершайте заказ онлайн Совершайте заказ онлайн Совершайте заказ онлайн
      internal static let secondText = L10n.tr("Localizable", "Onboarding.Delivery.SecondText")
      /// Бесплатная доставка
      internal static let title = L10n.tr("Localizable", "Onboarding.Delivery.Title")
    }
    internal enum OnlineOrder {
      /// Совершайте заказ онлайн Совершайте заказ онлайн Совершайте заказ онлайн
      internal static let secondText = L10n.tr("Localizable", "Onboarding.OnlineOrder.SecondText")
      /// Онлайн заказ
      internal static let title = L10n.tr("Localizable", "Onboarding.OnlineOrder.Title")
    }
    internal enum TystyPizza {
      /// Совершайте заказ онлайн Совершайте заказ онлайн Совершайте заказ онлайн
      internal static let secondText = L10n.tr("Localizable", "Onboarding.TystyPizza.SecondText")
      /// Вкусная пицца
      internal static let title = L10n.tr("Localizable", "Onboarding.TystyPizza.Title")
    }
  }

  internal enum Profile {
    /// Профиль
    internal static let profile = L10n.tr("Localizable", "Profile.Profile")
  }

  internal enum PromoCodes {
    /// Скопировать
    internal static let copy = L10n.tr("Localizable", "PromoCodes.Copy")
    /// Промокод:
    internal static let promoCode = L10n.tr("Localizable", "PromoCodes.PromoCode")
    /// Акции
    internal static let promoCodes = L10n.tr("Localizable", "PromoCodes.PromoCodes")
    /// Промокод скопирован
    internal static let promoCodeSaved = L10n.tr("Localizable", "PromoCodes.PromoCodeSaved")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
