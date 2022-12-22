abstract class MoviesStates {}

class MoviesInitialState extends MoviesStates {}

class MoviesChangeState extends MoviesStates {}

class MoviesGetPopularSuccessState extends MoviesStates {}

class MoviesGetPopularErrorState extends MoviesStates {}

class MoviesGetUpcomingSuccessState extends MoviesStates {}

class MoviesGetUpcomingErrorState extends MoviesStates {}

class MoviesGetNowSuccessState extends MoviesStates {}

class MoviesGetNowErrorState extends MoviesStates {}

class MoviesGetBudgetSuccessState extends MoviesStates {}

class MoviesGetBudgetErrorState extends MoviesStates {}

class MoviesChaneFavoritesSuccessState extends MoviesStates {}

class MoviesChaneQuickFavoritesSuccessState extends MoviesStates {}

class MoviesChaneFavoritesErrorState extends MoviesStates {}
