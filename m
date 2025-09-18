Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DBF304BDB
	for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205896; cv=none; b=h6B8BGAGZNI68tDHo7/4ow3kW724e25/Nb0+7Qwo5/ZPeG8t3YVv7bjvs4EF3NIOTbHTIWkhWgHA6jsrWXo3FLqcS8L43+Bf8OuRBCApm187jMryDFU1ZqlsOMfre+aBLWc/2XGpK5RPH6+hV0gIiQKV1vB24DPiy4P5QTjYeFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205896; c=relaxed/simple;
	bh=myP/sybN2zsJVXA5VSxoEq1YkiH03BHAZFTkykC2GiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8QRf/PIZ0zbuevjjtJEFjR95Ux6qr0rzAdWd8vRWYYTQgtqWN0IMsweJVJqurb/0tu8GkuE/N8K5KX+PiDj+BJtQKKsxS1Hscwyv/bYbypfcrVvfyufueRxR0EFRMXw3PlClGs6dkamF0LGQu2SZcmVuesxR76n0/xRdpw+uEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXTV8oTV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXTV8oTV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33067909400so584066a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758205893; x=1758810693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x7wpgOqV2jwxbf7nUbBy2XlSiAc50BZhVeubzU1uvBU=;
        b=XXTV8oTVX6+S8cB3egbJOi+r52l5pS2nTdxLCu3XgCnMJElQ4K7ATWx1gTLCprfKUK
         nQgtAKfeTNowQfoDA+TJVUvxACXAU5g7SX5/YuHWRmZd4uYmfwWBNM+X1oPelM98XG13
         XDyNcDd8MYiEllydXIvpI+V4DL/nH6v+LS0ZeRsSRuS1fy0zk5Z58LJJ8tbrCvvqfhyH
         +/geSbKkYMYURYnyK3n7BJ3l6rnJ3C9Ct5wTV9KT7Eid1PubGWPxkh+2qVqQwpSwVuGd
         dPVlvuTmODDqH3aYI72ZNNRPOE64uPlp5llb0m10owIyJ6NTZVte2z7IXU1vhv4o/YBR
         VLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205893; x=1758810693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7wpgOqV2jwxbf7nUbBy2XlSiAc50BZhVeubzU1uvBU=;
        b=VZD8aoWXKmzCIdb3DYFtWSLvZvIkDw5qgpUc4pQcxA9/kKm876Dp+wnsFs0eVq57dP
         g6nb2gRRdiv36sedQ0nfbF8ua4OJZeqeRllLcCNbYvcUZ54p0g7Hbky6PtZ8Xmts7+O8
         MNAJgKgYMmm52Yu5ctMafbCPIKjT3aieSG59HOx6ANoMV60TXsYIJpiAZcEeuQRcPOqA
         tCRX7p6iMrGuT01POX03V10U4ExnVTYKqAHpicE4OM0MVvaRx3NQ4a+PVCTyjyjKd9vE
         Q85S3oDhQcQLcXARz1frCaaRlNZOqOBufVzkhdo9Z6/dQ84SclJBpFxSRP/ebIfqMRPc
         gjyA==
X-Forwarded-Encrypted: i=1; AJvYcCWN+96OrmQ8usQklDNwoRy2uSUbYz0FVpIAVAZoAyyxUSRDghGy3n3bbX60BpMPf6GaQ954qUv5H5B3Fwq+WmxNB0Q+Tas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXo54j2lFD4KQub/3DqPx0lOJskobCFzv8wy1qR2b5kNYe9s1M
	X044mLgU2Tqp99DEf+TDpx+7CblBv5aYhCDlpbdG2jmc2G2UrOOzuGsgLBf03JDWeWy7TvJcDqi
	fx31DLjDKY5xqqaNTwoCp5+rMqX8VgsQqmjnBoAVP
X-Gm-Gg: ASbGncvMiMpE51Bk7Zyg2Dt0HbVsIzdDRBeJp+YyO6OIq8jW8V8jHYkCLhYL6gW01Wy
	ce/SCJTR2se+laownWDEGMShkFFoqtslcWP7Xs9HGrifjgNYf7GYVap6+zMl53sGH5PSEJrsdJt
	hOZlNWbcx14+GsbrPUeC1zxv074axANVnmqC+0XxQfh47+tw4rOmMYar3V6n5wRUJQ8eyuM07r+
	mEVQ2D6pKVEnxGFlbsBwUR1EByL7vh7Z4+uMg6PiVSeKu7+4sROL98/9sXu6A==
X-Google-Smtp-Source: AGHT+IHYGUcixIR/dwWsgGEgFB1TOwlgrZ0O4FlqafV2iJGSlcEq1KnUzPyMPrhTBrvu1VqtuDJ2xHHxKwyBuVmjxY4=
X-Received: by 2002:a17:90a:e184:b0:32e:b2f8:8dc1 with SMTP id
 98e67ed59e1d1-32ee3ee55c5mr7425841a91.10.1758205892532; Thu, 18 Sep 2025
 07:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com> <20250918141511.GA30263@lst.de>
In-Reply-To: <20250918141511.GA30263@lst.de>
From: Marco Elver <elver@google.com>
Date: Thu, 18 Sep 2025 16:30:55 +0200
X-Gm-Features: AS18NWD0SUeFqGV9WlY2IdwTn_KEVlrUb6EWkUXQGUd586AZF2O57bI6Ojf1TCc
Message-ID: <CANpmjNN8Vx5p+0xZAjHA4s6HaGaEdMf_u1c1jiOf=ZKqYYz9Nw@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Compiler-Based Capability- and Locking-Analysis
To: Christoph Hellwig <hch@lst.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 16:15, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Sep 18, 2025 at 03:59:11PM +0200, Marco Elver wrote:
> > A Clang version that supports `-Wthread-safety-pointer` and the new
> > alias-analysis of capability pointers is required (from this version
> > onwards):
> >
> >       https://github.com/llvm/llvm-project/commit/b4c98fcbe1504841203e610c351a3227f36c92a4 [3]
>
> There's no chance to make say x86 pre-built binaries for that available?

Not officially, but I can try to build something to share if you prefer.
Or a script that automatically pulls and builds clang for you - I have
this old script I just updated to the above commit:
https://gist.github.com/melver/fe8a5fd9e43e21fab569ee24fc9c6072
Does that help?
