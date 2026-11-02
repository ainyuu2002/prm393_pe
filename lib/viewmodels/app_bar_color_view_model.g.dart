// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_bar_color_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppBarColorViewModel)
final appBarColorViewModelProvider = AppBarColorViewModelProvider._();

final class AppBarColorViewModelProvider
    extends $NotifierProvider<AppBarColorViewModel, Color> {
  AppBarColorViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appBarColorViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appBarColorViewModelHash();

  @$internal
  @override
  AppBarColorViewModel create() => AppBarColorViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Color value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Color>(value),
    );
  }
}

String _$appBarColorViewModelHash() =>
    r'3ebe1b2ce4a624a9601fb1cc9bd41b5752bc4419';

abstract class _$AppBarColorViewModel extends $Notifier<Color> {
  Color build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Color, Color>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Color, Color>,
              Color,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
