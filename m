Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647021E515;
	Tue,  2 Jun 2026 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364577; cv=none; b=l34kSCY/45pgs0XqwLnBWvCGOc9m4I2seG2xuCcWCc33jCCmQ0/qZuKDkWWyMRm2rHq9iUkMmwaQI6l4c3N1OPrgTzKn/4F1MKTshOGU0TPcxsIo3zXvPo8xvz/1Be/jOaIH22j7MgZizQjrIPkewkTRc+IGYrxsrMvFM/VHPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364577; c=relaxed/simple;
	bh=HqpZj31f7T8Am9sNA3UW15wRg8mZ8ux30j6CLDfZ1vs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CtoG0UBbLFk6jaKIhJkaeGf7gElWci10fNduLcKFPQhjeqduhsnYYDbzLr0IzRhO5jS13ckZ5TV3gDLpaYvB8qHiDR9vxpOPCs9h3FKwQrnoUeP88XO/kJfi56kc0eq0RQzOrvwocjnwSR3sHKx9vSxWZvnMjYSa55xDNLHVURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvyHKTwj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvyHKTwj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 723941F00893;
	Tue,  2 Jun 2026 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780364576;
	bh=HqpZj31f7T8Am9sNA3UW15wRg8mZ8ux30j6CLDfZ1vs=;
	h=Date:From:To:Cc:Subject;
	b=jvyHKTwjm/SXOZi1V7JgHn7nrdfojauT1g/9c46UcGfXu8xbzAaj1/IWi+KLQp+Bu
	 EylvAnLCipovrvNkvCAzmUxl9Zlu95JdQiDh0Z9mBRcoD1T1LXLvp6VQ77cqBac57G
	 ZLvrwyv+jsUdXtGdC6hOAjPJTj6OEMHLuC55AQzZN6qDlA+pkEuY65193qAivWEs4g
	 8g1Dxp1rKfFAiHfN078tyRCgvkCyRALLzMv1qBfYrQwBL/OcosBD0YE4hWIsf1H07K
	 3VebE/lkxM5qWOVcNtq54TDyA9UcS5fy76PYOoco4c2vtmjv7Vb2hN2MEn5lTvBZwL
	 M16yPZhfsaUJA==
Date: Tue, 2 Jun 2026 04:42:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Subject: Landstrip
Message-ID: <ah41G3F850HLeiBQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I played with an idea could Landlock LSM be used to do conceptually a
better fit sandbox for programs such as Anthropic Sandbox Runtime [1].

After some missteps at first I got it pulled together quite well:

https://crates.io/crates/landstrip

To see it in action I also have a fork of pi-hashline-readmap plugin,
which was a cherry-picked test case I wanted to try out given it already
hooks the bash tool command for compressed output.

I just thought that this might interest some as Landlock is not really
over-used kernel feature in "application sense".

This is a more lower barrier and more failure tolerant to deploy than
Bubblewrap based container for this use and purpose in my opinion
at least.

[1] https://github.com/anthropic-experimental/sandbox-runtime/issues/291
[2] https://github.com/jarkkojs/pi-hashline-readmap

BR, Jarkko
