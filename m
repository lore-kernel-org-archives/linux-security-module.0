Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E63358B0
	for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769509087; cv=pass; b=udMqYOXAI82mLuDmaCvTQUoRtyQM6FHchEg8W+x0MZ869vJ7HcMry8csl5o+HP6uyth/7TL1/NbuLexx+72QQVt5VQGsvqRtCw9V7QsdTsx8H1BPZp3aMIu+ql/t2kNAXBQH/+URnMz1KHvGu3PzIcJ7o1W5TbchVp/5d4EZ7DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769509087; c=relaxed/simple;
	bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPDqQ+ROpjASTLaLpLnCh9eI3bKCYqo9WpWL3Q1FvqoRA86xeX8Qs/6CGFuuwfrsY+BPkXN82IIUbK4o9DgyI1q9k/nTr85ki6kr8/Ozo6xHAh8AUgt4R9gwyv4xhZOsPdhiFdNnt9FRTD+0kelDVSTtOzFWI8OWNEa6QzOolcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CBOsHD/; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CBOsHD/"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12332910300so2129447c88.0
        for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 02:18:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769509082; cv=none;
        d=google.com; s=arc-20240605;
        b=MlcYhk/hjsZoAOIemUHdjryy/Sm5tx/THbNEASl8ERjlvGpvhryRjMa7yXf/4s6IcS
         C7oFv05UbGWMJBeFTyAI3+I6b/Zj3zEd9qU/y/07ISbDOoTj/XmgxNWSfDtruxEm+smL
         BP6v0KNVVoW+P5rrsE/z5mXBEmJB3SNdK4U+AyzKAahTnRYooQZwM+arJjZjd/bHv2eS
         IqS7TDNQZ832dekn8XoE6nn2dsAbMHyoccpT2bcOCFjenKf6vL7+zT4SMdS3UpYJT35Y
         uoEL+z6VEwFw99La1Rb1nVzWly+eB9eky/J/VPLb9N3ZqD4L+PfNoz/hFvQuml2nmPCV
         DRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        fh=pRk9KlCFX38AyBUVVa2y0e/BWztqq9URPf8ODSUdLNE=;
        b=lZNXVShgO3Ne/DQIkxlU7l3e1xaT8ABkKImKTum+8E7QbRJAoeK7O3L5sH6trKheGC
         QQtAL7a1AEvC2fABnjn3LOgUmyPFNHJgvrDkMp+/N0eUbVU1HHIOp0O1+jTvegIlMGIC
         V/AOEuMwfcMrfCKSUUlcZF8ISuBW2nJgtPeYDHQZZKEIK1uixEtVR0zHu9zjCSS0udUW
         nI1kGALtQ1/YrMDtJSMYXLHbeBoSaDzJY5uPeitiIfYPMfeftl+2yaGQ8t2gC7GemXNl
         ohOVqMR5kxcuAXEExp+GvkTDZlm6dkv6XPsNeJ5pVRzssd77CPQo6xPctw9M3rA73D/f
         tueg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769509082; x=1770113882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        b=0CBOsHD/uKOv95aR8OTAbtRyWBxyLJ6N1fESKzC2veqVx9JPRAR/Gsg+n8VRUW2Hp3
         EG6v3t7dFFHmx4Qe9/enHqvAYc/MN+zbW34Q0dIEP/dBnHyBwmTXLN/s4AgkzfrYowyK
         TS9/3JGwU153BB0kkOIvZ5Xtjd+Bp8Z4TnxiAJfhMEvuCB4na3T6n77gyhHa/UDpEb0b
         IgALtOGmCw2o5+TNyDxryyFP5U2h1On49wPhmsdnKC83ra3MXi1Xx96djhullUZFhEEf
         Bu8bIyKcXqPDpnJ079sq0S/S0xkr66rrSYp7sxWe3EDfxUs2fpKiC1ykKYevzeLX0nO4
         YmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769509082; x=1770113882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eWZA1QTRdZDTddGYL8SlE552QBQW/sLGGoi37wJCfo=;
        b=qZQ1sWkumuhWilG+MshPrTBNKSASXswxb3EpGJin2yZfopUVfCVqshlZg3f+QgDuyS
         ou8BEfo8fhrp3JPWEovd9mXlBY4koJLxjPTP6CODxzBRpii6uAwlFJFZ5SYZV9gTjXg/
         8WQjzwrmxVsh2QrrXtgzXo32LUpw6SVLi/1ghOMYIhZFoVmCq54PBukAQ/Si0y1vsF9l
         j8R+ME0O2DFmpKk4dV/fLXWCVhcG/x+rcLMBBlW6UXXkJsUw6X6H1x/fyPru8F5uclF3
         RL2bEzQxTDYVe42VUMk6gY3C/lqa7omnLnT1o4DN3zBslIqfIcgWTcHV2ZMDitsjGS57
         IwcA==
X-Forwarded-Encrypted: i=1; AJvYcCWm4zE08EfgGckja0NA+CO1dljo82j0bjD+KqdougdwpSJ6RXKn0v84UgrPKTk4nqqt2V3pIH+XfhBisae2+TsG67xwX6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCy6r8c5uFXTNDp6fU/mZuHYysXMvsXn/7i6LlmRWXpHLD3Ni
	7qCu5zt1ro3vDH755LfFofRM1TQjgWwbxndGf7UL1MXovxDLlGypBzjsRl9V98UfDt3x0LeMbdB
	p/huD1d37D9FT8a3AhrII1SaiYCpX8+NPsM8dfiMg
X-Gm-Gg: AZuq6aJcufiN8++77L1fLaW97sOgAjPY6vlFdtjZYgcsA/KIqz87stbRIAwiKfsfaxz
	XYVtaYpw503EPpSGEaNh1RDVQyYx+kPfSdTHsGVY9A8zF5e4Au72LFJnVlnNXDBWeVid/Yybc6V
	QA43UWdlKpBwO0mXr0JX/eApP9IaXUh0pAcpCJzXtnjV5wuIVmqChc17ezvehpxcXzJoPF/bhCM
	g1RvpRGyaUk/ZCrVLXKG5kdAsNDB7FvmT1o7mT1BCZ/5V88c1YbAYlN+gzKWIM22THmDoRXuDne
	iAJqXv/blJi13i9ofeBkADpsjw==
X-Received: by 2002:a05:7022:6985:b0:11e:f6ef:4988 with SMTP id
 a92af1059eb24-124a00cd55dmr806676c88.36.1769509081547; Tue, 27 Jan 2026
 02:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-7-elver@google.com>
 <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
In-Reply-To: <0c2d9b69-c052-4075-8a4b-023d277b8509@lucifer.local>
From: Marco Elver <elver@google.com>
Date: Tue, 27 Jan 2026 11:17:24 +0100
X-Gm-Features: AZwV_Qj2UVNnjgQTvKRMxq0N2rMz8K4yMXQyPWTkZbJrWul7iRYbem2vd2u4cZs
Message-ID: <CANpmjNNHmOzaCSc9hQJNuzNVHXA=LRgXB4Q69FNk6wBuuJGdAg@mail.gmail.com>
Subject: Re: [PATCH v5 06/36] cleanup: Basic compatibility with context analysis
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 11:14, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> +cc Sid for awareness
>
> Hi,
>
> This patch breaks the radix tree and VMA userland tests. The next bots didn't
> catch it but it seems now they're building the userland VMA tests
> (e.g. https://lore.kernel.all/202601271308.b8d3fcb6-lkp@intel.com/) but maybe
> not caught up to the issue this one caused (fails build in tools/testing/vma and
> tools/testing/radix-tree).
>
> Anyway it's a really easy fix, just need to stub out __no_context_analysis in
> the tools/include copy of compiler_types.h, fix-patch provided below.
>
> To avoid bisection hazard it'd be nice if it could be folded into this series
> before this patch, but if we're too late in the cycle for that I can submit a
> fix separately.

Thanks, I saw. I have a more complete fix I'm about to send.
