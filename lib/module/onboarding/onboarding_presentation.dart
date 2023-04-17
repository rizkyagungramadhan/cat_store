import 'package:equatable/equatable.dart';

class OnBoardingPresentation extends Equatable {
  final bool isLastPage;

  const OnBoardingPresentation({this.isLastPage = false});

  OnBoardingPresentation copyWith({
    bool? isLastPage,
  }) {
    return OnBoardingPresentation(
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object> get props => [isLastPage];
}
