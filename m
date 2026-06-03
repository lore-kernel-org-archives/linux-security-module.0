Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F43AD52B
	for <linux-security-module@vger.kernel.org>; Wed,  3 Jun 2026 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502701; cv=pass; b=uDUG0VYBYpzGen10SigqWLpGvd2xNrWI3mJEQJj4DHj2qCgmnUTNas+W2TcuSjcQXSIrWxh3F7+j+O/V/+gdMlAvU2De6Tj/Z/Y9gKiyPPUsSpUs4UCVYdZHewY/rBNXeAGTGtLSavPxlkg9BSAK726cJ61CPaiT34PlUJ4lcZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502701; c=relaxed/simple;
	bh=KdK+HJPfqWh89Zp4ToM1VwC3m/NfENtvgJL4u0B4uXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJMmuNILgtLV/kKT9TdBsB/fpUVgnKMYEmSJtUCNYl04IN8TtdIIPsn6DL3n2u72UHd2HV6SGq71AS6Ul20HVP750ERrPD+cguaSPgPFHz09RcEvYie/LAzcnFDy00Xdu5t4i428JE55zH/W59PsUAcqe+63Ogt/B3n8OKQ5oFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bEq5JVUy; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bEq5JVUy"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c858cc9870aso478484a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 03 Jun 2026 09:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780502700; cv=none;
        d=google.com; s=arc-20240605;
        b=HAIRPK7oNJjwqWJ2/kKZUHSAK/xT3MGS2ZXh5kgiDDpjLz2YUuEqO9VYPiIqCuhbWX
         bFYo1Hfs8SpGrPD3iz4uovz4W+oU2dy1KVLxqzJZNoQrfoQ/8EA44bRW4vwnEdTZW2sK
         eS8DyrHuNdlMYPyyX7wgLt6jijjkuFePY3P3dugq9VWKm7OCQUi9jYqFYZIObkYbDw5K
         /j9iGSXYBu5zZSO2QEmDFet+ntYOKS66zokKZOCLIrKjM+7Og/hsMcCR11J4WsLTfAtI
         WSoYJXZbytt0ydX++gs383N19Hw/59FxQk+wihz/IzN1M3HK547oXj4HN4f+HXdb9JnC
         YNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RJiwIu7uyZAaPlamCdTOHC+XlHLfDNYUsMpOrpvH7ck=;
        fh=VDGojWGsg9MJP4OQbGYe643YaajqVfs7yDPNpHwEqQs=;
        b=NWXtZPCuIuJXGmZBZJQ1VQHSMzt9fbTbkIGjhMpPmAenGyByxf1HaRhRjXAynIqmNq
         rtS4UJvwG5TJ6b2pO7rl37/6IilTk0xc9TF0A1d7+3tifl1mg920rKNW2+6y59dKu1A2
         cYTvzfC8BGsBIhF6E52OGdaBQ+JdiNWFKVaYxLoFAf1BuN7dDK+i+b586/rGEZ+ee6GN
         COCmfCj/GrGhzxerocmyLL0VPoIEO813S7kZY+xeYmcp0RRUMuFT5dQz7Bd3KGaz2Q/A
         lJjPqaWVNY+caO5AnwC316Wov47EOyHEp/vlR5bIpI0pSxUJS9eLAVrNb/rqGJQTHvFY
         k4MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780502700; x=1781107500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJiwIu7uyZAaPlamCdTOHC+XlHLfDNYUsMpOrpvH7ck=;
        b=bEq5JVUyik36GznJczEmGp/zvq4S+t4sSQGOdFrNgHDAND8PfN9Jy6RKIG6djwP2V1
         JqQV+TZNTTRJ1oNo1sO3ehK+qWCOk8sj61muK9fh4S3QqbpUJf9exaTJaxa3a1BaJeua
         2vqdWL1JblHn6H8rkvvntMOZ7R5BhjjWC5/ckDpvAaI5T9wmazv0lsk3iLkFPFbqdsBc
         pFP/yTbjeEH7SXox3KDwLwKPJbuciNM2Hviy6PI2pk9VYcY+l6vKNgXPOQd4uZDvBkMb
         gXotbk0hlQl6WGbIgxZ7J4ZIUNRGAV8CX+YPsr0oiqF6Ih8e923eCXrZl4RjD4ETaD0X
         zstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780502700; x=1781107500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJiwIu7uyZAaPlamCdTOHC+XlHLfDNYUsMpOrpvH7ck=;
        b=s1IRsoIHCBuzYlxiMokTliy1LYYVj0Qr9DfNuOh95VIdsWfFBHJJS0DXFJKBnLGpUX
         8UPDGrnW0UIHFUiCau3QftWkrV3ZDVuuNkX6eAvEelaKdJtOF36CBJ3g1mNtIAERCFHC
         r9XrhhNlBaA2CK1/CWEnCJUv5Mg1U55jWvLO7y4xPd5AiF8icNLBeFZNh3XkGrbnZyPM
         Kpak4ydC7opbwUJIrIYn5zY/Xlxq5rngzrbaLmn8VzOFZIVa/IPQjQY+Yg9M/xXi7x5J
         +Ux1bB7PFs3gU14Gd4vSe6PcZFsBTsmKlmRHz1trgXrP9y9hIft7f0MOwIzvTuz9VK4N
         /l1w==
X-Forwarded-Encrypted: i=1; AFNElJ+x0/xuFA7Ich6QMYSpTEDTuLZkqR4z+58JuBoOQ1h2VxL2+E8baIMeiNW7YMFEu/ZmqJNk6l7ByJa94fhzgkXaCspV7W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO1MP3lrmS3A8eRT+MxqrqzbD88QFYmHN53BTu1TvBfuP7eAUT
	WEWQ/9aNpEM0n7XRRRQLsxzshUc8jgReBzsxjKxVpTXRpjAENsfsByORjnt1Ekaul6nZofX/i5o
	JF7ELKp23qTQGlRy0O7kFh4kOSkHSYcp5ozZkjvlU
X-Gm-Gg: Acq92OHNPjB3vWhDTuYXBvDgICUKLSkUO3so/lMCYZIpmqVljVCPTTZNsT4vLKUaIr6
	BTs/Sc6T21vBFd6LPXSBKX+CmdUV8mhS+KOFKrWYwQiomqfH0YLzR8ZVjlD/YYRBvTfajOgTdni
	jIMqr4esH84YrxxVN3/bcjH6QQRbiLWoxN7BRgQbobXfjWxIawuur2cSbyQzgOuajIkpcJtbkV/
	5z5sqEREw37qxTqdj8c+6FPtSJfe1RZFklvmVNMjsUZgRZuKMpAOR3+LuP385las+g2lUdOzDPT
	EGFKihPmFxKmAqDdpw==
X-Received: by 2002:a17:903:2352:b0:2bf:361e:3edc with SMTP id
 d9443c01a7336-2c197a1e664mr634245ad.2.1780502699785; Wed, 03 Jun 2026
 09:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com>
 <CAHC9VhR5Ca+WyP2OiNGtL1SqHn0SwLe=M9SB8D2bxtdS52quhg@mail.gmail.com> <ah51DY5yfaNZejBd@google.com>
In-Reply-To: <ah51DY5yfaNZejBd@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jun 2026 12:04:47 -0400
X-Gm-Features: AVHnY4Il2nbhkxMxu_bFZ4TFGt7Ipvw1ewyd2x_7Gw2WYSaTiJOB7iM0xVPzXF4
Message-ID: <CAHC9VhQyNzxJgdMkmEsOeAQ7Wt2L+eW6aNLjeoYmnCQLmcYRnw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Delete task_euid()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 2:15=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> On Mon, Jun 01, 2026 at 07:13:37PM -0400, Paul Moore wrote:
> > On Fri, May 29, 2026 at 5:33=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > The task_euid() method is a very weird method, and Binder was the onl=
y
> > > user. As of commit 65b672152289 ("binder: use current_euid() for
> > > transaction sender identity") Binder doesn't use task_euid() anymore,
> > > so we can delete this method.
> >
> > Given the problems from last time, it seems like it might be prudent
> > to let the commit have some time to "breathe" in a proper release, I'd
> > suggest merging this not for the upcoming v7.2 merge window but
> > instead waiting for v7.3.
>
> Sure, that makes sense. I'll resend after the merge window.

No need to resend if there are no changes (see below), it's in
patchwork and I'm tracking it so you're all set.  I'll send another
notice when I merge it.

> > > My suggestion would be to merge this through the LSM tree.
> >
> > That's fine with me.  I'd also suggest updating the commit description
> > in patch 1/2 to indicate that binder is no longer using task_euid();
> > it currently reads like it is still being used.
>
> I guess this occurred because when patch 1 was written, it really *was*
> still being used.

Yeah, I understand the world has changed since patch 1/2 was written,
which is okay, we just need to update the commit description ... which
should be a trivial task.

> Perhaps we could pick up only patch 1 now since even
> if we run into problems and Binder has to go back to using task_euid(),
> clarifying the docs is still useful.

I assumed that was one of the reasons for splitting the changes across
two patches (reverting patch 2/2 leaves patch 1/2 intact).
Regardless, we're at -rc6 and with patch 1/2 being purely a comment
update I don't see an urgent rush on this, especially considering that
if I did pick it up now, it would be for the v7.2 merge window and the
binder/current_euid() change will ship in v7.1.

Let's update the commit description - you've got a couple of weeks to
do that - and then we'll merge everything once the v7.2 merge window
closes.

--=20
paul-moore.com
