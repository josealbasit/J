function lim=limits(estimParam)

  epsilon=estimParam*3;
  lim=[(estimParam-epsilon)(:) (estimParam+epsilon)(:)]


  end
