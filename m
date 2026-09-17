Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B647F788;
	Thu, 17 Sep 2026 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641953; cv=none; b=DaYCToJkER4TR1mC1jh4pawO9YZ1v0k/VXolQwLb9Q5RAycWRo2cc3Tmndo8Xe6Ru4NnvJ0IGv7DkWY1nT66DqxCabJbMO8JUrPZdREgl2iZJq8/9nD8vHg7+MgHS+rj7+aFYDx6UXeCc7r/FjT2b7BKeYpqi0rozWRbxl94yTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641953; c=relaxed/simple;
	bh=ECo9cdo977FkiesxllRgUw3yGG4DUboNuVLo4Q7lpYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj2fPcKuGThNWY10JitFbpknsMJ0ZPlHNvL+5oJ5oReangeLulOsIopQKymTQMXbf57jxo+ML6Vbkly05v2l6z0SHT6nSr+Wcn4qzABpgndX1PtoJkF4nQBvNOaSfygiz+xYRY1BxlsyhkhaMHUxh8ZsCK+BCha2WhWD0t+1TEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zop+mrjL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IjKXUjsu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zop+mrjL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IjKXUjsu"
Date: Thu, 17 Sep 2026 12:45:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789641950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTPmmmxEvbkY6yRJOu+LwHlz+vZaSs5Q5lGUiSehc0g=;
	b=Zop+mrjLVSwa6YNF0PYj+B7tNsAhRULqgtoiBcyWSOOzgPW5fCutxkK0csbN1RdDac7AB1
	C+9RXDu5HRkLR3xx0FkFDkU5SloeM1y+y1ainxX/Ha8WbfTM+AJPF/ypJUVipMPMdf3Dcc
	T/Qsbe5F3LM2n0ysVcoEgTasjqcThOvRQYQ24/VMynKNQ8UEy3QqEiFKiqPYQh/yA2ONKI
	N3ZDF2NErGvCXU8dYsn3FGY4KmV87XatDS3QZovYROuOnL8LKuBWDEzwOTlrCpdG+yCzgv
	i6QFyi66LJYOPQX2ZFgsyKSuI5VTwqcX88J/zR5+lk/4kkxxsjuHv2G7Nb0CnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789641950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTPmmmxEvbkY6yRJOu+LwHlz+vZaSs5Q5lGUiSehc0g=;
	b=IjKXUjsu4IxVTuMW0xCBcGaYuuEqMPKHAbcejSkWIKlgq7fVoHitp8O7rltsI5wyQ4h1i5
	XFTWHeY6uJgEj3CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Arnd Bergmann <arnd@kernel.org>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] landlock: work around gcc-16 -Wuninitialized warning
Message-ID: <20260917104544.3trW9Jq1@linutronix.de>
References: <20260915201036.3527935-1-arnd@kernel.org>
 <20260916084947.6QDy8KZQ@linutronix.de>
 <20260916.shai0tha3IPa@digikod.net>
 <57b5869d-7411-46e8-ade6-6d2a7fea02ac@app.fastmail.com>
 <20260917070915.Ix8TOn5Y@linutronix.de>
 <1192c2df-d39a-4d43-ad57-68b0167759f5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1192c2df-d39a-4d43-ad57-68b0167759f5@app.fastmail.com>

On 2026-09-17 12:26:17 [+0200], Arnd Bergmann wrote:
> I checked again and found that this is a config that did produce
> the issue a few weeks ago, but doesn't today for me.
> I found a different config from this week and managed to reproduce
> the problem on today's linux-next using both gcc-16.2 and gcc-17.0
> from yesterday, so there is still a related issue that is not
> fixed in gcc, even though one at least one of them was fixed.

Confirmed. I see the warning on arm64 while x86-64 is quiet. The patch
fixes the issue.

You might need to update gcc bug tracker.

>       Arnd

Sebastian
