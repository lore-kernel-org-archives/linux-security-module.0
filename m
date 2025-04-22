Received: from dd44826.kasserver.com (dd44826.kasserver.com [85.13.151.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F725F96F;
	Tue, 22 Apr 2025 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.151.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320942; cv=none; b=spi6TwDPehnTlp8EiZOsb2t2RCcyWydrV2VhQkmqDwxxgeC77x06evv5072iFMbMihXKOT/tlvATdOQNoD69uXzZ3Rrs9/yQQimAC83AD8TvBE7dEdeuW4qo7cpoTkxEirHoSo3uMNyEqji7j1lXUYcG4RqnLtP8qeE2gX0UXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320942; c=relaxed/simple;
	bh=GLcpMPy7md/nAw3qC1GMlS20q+b2Xd+N/J4eoHnOFFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qleeXDd4EFyYmKvcSTGrSDfxUn4FYKjcEflJnnarmV4NxQK+z9Zc96mWye2rFt8meWILIGLoDjV97+dLFBV2QhCfYoU+SYzA73mKDIeC6F5/aVWhqPlVz6yNyFe/Bj2QcKRZVMqDsY5MvGFbc2vPPsAxhR/GqLnhTSJLqcQL4eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de; spf=pass smtp.mailfrom=o1oo11oo.de; dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b=B1BxVoGc; arc=none smtp.client-ip=85.13.151.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o1oo11oo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o1oo11oo.de header.i=@o1oo11oo.de header.b="B1BxVoGc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o1oo11oo.de;
	s=kas202503061048; t=1745320928;
	bh=ycqs7QdKcMOuNbzmqf4ft41vq1eZBegNFxvwwMj7CAM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B1BxVoGc+hAHvsdJiIiv606xD3SyiQ1Df9bLXhuMMPwJ8jR6xJr7DWq3zlsX3WzJd
	 fGXcVw9w2H9nFlClZfAtwRv1oEvsHWCu/Fywls8IS8geyiymDFhkYTCs4x5nup33HN
	 nqULL0uOrpkrjEIy57P0+HF+aLE2LBWuCKn2S1xwZUbAfWXRc9iOpgolUGzjLZyrDG
	 q2/+b72/7qTpkR14qkwlC4lZ4lJhbwB60h2uHQd6vw2Eemg27LMsIt4ZhMwd3rCrr1
	 ZHQDIyJQf1nfc7uSh9CdsauuWQL5a11uH6M7LQ+3IJnfi6Ma5+koWuN4k+8+CMwKrh
	 FDCaQfecImGEQ==
Received: from [141.24.109.69] (wl-r6-69.rz.tu-ilmenau.de [141.24.109.69])
	by dd44826.kasserver.com (Postfix) with ESMTPSA id CA877B6E01A9;
	Tue, 22 Apr 2025 13:22:07 +0200 (CEST)
Message-ID: <c1eb852b-f8aa-4ab0-9579-19eb0d383cb9@o1oo11oo.de>
Date: Tue, 22 Apr 2025 13:22:06 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] lsm: Add Rust bindings with example LSM
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250416213206.26060-2-kernel@o1oo11oo.de>
 <CAHC9VhS=jWEZqb3MqCtUAJhY9ci8d_N4H6CqWsYU0YmEG=8_yA@mail.gmail.com>
From: Lukas Fischer <kernel@o1oo11oo.de>
In-Reply-To: <CAHC9VhS=jWEZqb3MqCtUAJhY9ci8d_N4H6CqWsYU0YmEG=8_yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 21.04.25 21:09, Paul Moore wrote:
> Thanks for sharing this Lukas.  My Rust knowledge is still far too
> basic to offer any constructive review of the Rust code, but I'm happy
> to see some effort being put into looking at what would be required to
> support a LSM written in Rust.

Hi Paul,

that's alright, I was mainly asking the Rust for Linux contributors for feedback
on that, but I wanted to keep you in the loop as well.

> It isn't clear to me if this is simply an exercise in seeing what
> Rust/C interfaces would be needed to implement a Rust based LSM, or if
> you ultimately have a LSM you would like to submit upstream and this
> is the necessary groundwork so you can implement it in Rust.  Unless
> it is the latter, I'm not sure this is something that is a candidate
> for merging into the upstream Linux kernel as we don't merge "demo"
> type LSMs.  If you are intending to develop a proper LSM, we do have
> some guidelines that may help explain what is expected:
> 
> * https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
thanks for the feedback, I guess I was missing some context in the initial mail.
The LSM I'm using it for in my thesis is more of a research testbed (or "demo"),
so I never intended to upstream that. Since I still needed to create bindings to
implement that in Rust, I figured I would post them to the lists to get some
feedback and to get things started in case someone wants to implement an actual
upstreamed LSM in Rust in the future. This is why I marked this "RFC PATCH", it
is not intended for upstreaming, only for feedback.

If there is interest in it, I might polish the bindings after the thesis, so
that they can be properly used for an actual LSM. In the state they are
currently in they do allow writing an LSM in Rust, but not in a way a safe Rust
abstraction should.

Thanks,
Lukas
