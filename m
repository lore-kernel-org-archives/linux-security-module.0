Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971D38423A
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026786; cv=pass; b=i6lZN1jlxVqgdYizevQtROowoOvYCSuMJUduFwLvU2N6KyP50lzY9dcmNP+nm779ZjRrsNvlNxyXFfGo8uTSqNIa0iLi0tIyFQ4tF4mfmQ+utjfpHRH5h8eiazorR4jccS0hK8Ailtn79xw/re/ncj/GFq94zwumFA/c0uIlIzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026786; c=relaxed/simple;
	bh=6cZbDjgOL37MD41a4mUgO48Jw/rtoj/VLkwNf4EshIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmE3FsSVWI7vkvHmE9oRkaOOQAqGluHD9RNGWf2t+X7VneCDDDLFZVBjP1/+mVebvAfqFLqPjgXAMMQjCzfG+CSa9ssrVaYYyU5Wh6ouIdE/FHqrvgVYL+/4+puwNU0azRL5LVGFITgMb4t13sQyg03o4AjOZnmsbXnmP7Bsskw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ck61Fc5T; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ck61Fc5T"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacb8416a1so4763165ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 14:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783026784; cv=none;
        d=google.com; s=arc-20260327;
        b=Z4jlH6oCibthYNk/biASr5g7d50m0oUHgZSgSsWxvSwVCx2XSuiCJJhFUVOUA+KCwM
         O8shtn1LTTA76r3O76igFKqh9LzPok5iYvg241/LDnoflI2AQ4Vk29nzMfDFbyiNGpm3
         f3Z7ZPwWMr+dkEQBoLqVxbjqMz9sWgaQWsKYiq0qGR54BZSW79mKY8hwgIwv30gS8AR7
         ozr2lxmwygPwcDPSnM9L5z/nbF02G6NBA7bNQMGY9rVsbQTlbOd+L//RYO8c2cXfFcJN
         wz/DX/19rUhshUNbkqSx5kzH50bfZDBuGkbgJWNPgtqwKxaYubuRhNWokQB1JTh77hFT
         o+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AyIW9b1L4RTcWNQ05u8o4YPVZ1U+N1SMUlgeq725Esc=;
        fh=94/R/5knLTMwE8P20Zn9JX8fbXDAGv0mPzM3URZTMnc=;
        b=jIGSFCxc6DZKPaHd63EJhsNT0ak03c2rzDQ5CJpfojpVwduPzWZjLr0h+CnJWlzCOB
         LekehlkmKIs30yCzWA7AC0nv9hMWpjNGXSWdSQZ21VXGclvXFf6IxuBS3TZSRO3NHv0X
         UuWg1t7PcTNJndihBI+9As4lyWqNLJ8yhoxS1Uu9DhVAIEg6xmtuUSGgqk0SjTIjDNbD
         Zyn5ekg9pPhSHrf6hq5hwd4hwh9G81mmLBTN3fxppTLAuzC6pgML9ABlr1tB6JfC7meB
         2QLJRmc1YHdwjTUuJKRTre/YlmQY5r8ZfZuPJ3qT1Lk746/n9iN0ln6aigYiMPwQWcxR
         HHFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783026784; x=1783631584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyIW9b1L4RTcWNQ05u8o4YPVZ1U+N1SMUlgeq725Esc=;
        b=Ck61Fc5TJzIU09+axx+e6RLYwDfGVqprsoe1m2tRj4enLqm0IA8/WvBxd04tQAaBIB
         9lQUsZEYbaCGOpP8E4rC242gtPQnirRjBU+EOLWNY36xMxvff1qytC3d15QIMGCFTVRf
         n4mfpzQmQkbbOaEdaNFIzkkh3I6RmvoL09K4bkE2wlrV0k6U4oBom/XqLGIalWKessfp
         AG43lp7KJrk47m3/UJeuw13uKE7hVwwvGDiW7VmPyJF7aoC3JiTALcaHuF6uQf4i3jKt
         6ko+xoobjCKjtpAymZl/QgRORh21J4ihVvZXnWIaR5iRpxt+vFRhM2mg1MBaFMTzsO1e
         b8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783026784; x=1783631584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AyIW9b1L4RTcWNQ05u8o4YPVZ1U+N1SMUlgeq725Esc=;
        b=ojIkIqvQ5vV68XG1cd4rJlzZYYPPtnJsDymfOrgQrx0DvBtZZY7OHuKvsXH/bPiZ5/
         TNmbo1I45647k2JQUxvZxJu9N0xnQRfrd4Gn9o2lEtBYC3xUZQZ6EWs4n1pwB3IsedIA
         VZzH1F8HK7/9jV9FUnGxIFIUt6nQVrRN3hdw7lBzRbHOJfw9HJY85U4m8RN/HiUb92I4
         pGU8TXv1G2/2nPfCW49JZt4/+y7sMNlsnFAuh0sEWQzu7L9w8j7zsZ+Ttj5Wul/JAxhl
         hG6wZ4S+DZz8tgdmCEIZUmz+n93clmLvWaTQJ51xaLh53LqNAFgUH8XZbvRMOn1xBM/f
         crIQ==
X-Forwarded-Encrypted: i=1; AHgh+Roy7rDiT0njwutgMaeMRUGw7gp6niV+5sH44/yb0k2RQuTCt73GpQmJcZQHBujWNqWE9VntzsjyqVfoT4cYVsLMaoc34tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wB3YEhFNm6rC4tU9TxqY9zDK0e0WCaEDnqxtCCV/3PIqqWY0
	6RBUDzeQ6GGeiZda1a67qLHtBWBThaTQIOyra/xDwQZkgsoGVXFf0+c7qNpsrSd5wkFVFWby9U/
	aRlvvMZIZxX7WQRJv8hwzzU0jzX0B/r/9NucCHoTN
X-Gm-Gg: AfdE7cnoN9bhZoiyiizFLolL76fRun910XujVNR6dTyC2uaYP0oPriaj6qG9VqGCjEV
	denLIcGMJ3sMDJD5+DS9JQLFwHuvGRTqMlDlKTsHdpFLNmh1mTeNIvCz0snxapv2jqIbMI4z+s+
	JhJJ/nU9zoJl0NZtlz7OseEHiIi+t/Qo53qb0G1KQ3ywHzNx9y6fBRusHQGaSiCsP6PHv0mamLW
	Cb7BkgI/c4jv7hR5oYiUb7tGIBUXUv7Oqz/Ke4ZHrzMoSJQr5OyKRC7jfZQJDATapAwXzgQ
X-Received: by 2002:a17:902:f710:b0:2c9:854b:d53c with SMTP id
 d9443c01a7336-2ca911f9311mr68892545ad.36.1783026784472; Thu, 02 Jul 2026
 14:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com>
 <CAHC9VhR5Ca+WyP2OiNGtL1SqHn0SwLe=M9SB8D2bxtdS52quhg@mail.gmail.com>
 <ah51DY5yfaNZejBd@google.com> <CAHC9VhQyNzxJgdMkmEsOeAQ7Wt2L+eW6aNLjeoYmnCQLmcYRnw@mail.gmail.com>
 <CAH5fLghJaFXheAZqKyM9Cdo6iqTw1W=haA79POhmZWEfuKujRA@mail.gmail.com>
In-Reply-To: <CAH5fLghJaFXheAZqKyM9Cdo6iqTw1W=haA79POhmZWEfuKujRA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jul 2026 17:12:52 -0400
X-Gm-Features: AVVi8Cc226agFjsV3IzoL0ZtqLK8mwQAJ-H8dg4RuGGydr2Hd_jseubNHLDGNTk
Message-ID: <CAHC9VhTfOnOgOzGk9==wJYKx5gAi3Zf3oTwbj183o0_xxrfKag@mail.gmail.com>
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

On Wed, Jun 3, 2026 at 1:05=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> On Wed, Jun 3, 2026 at 6:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Tue, Jun 2, 2026 at 2:15=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> > > On Mon, Jun 01, 2026 at 07:13:37PM -0400, Paul Moore wrote:
> > > > On Fri, May 29, 2026 at 5:33=E2=80=AFAM Alice Ryhl <aliceryhl@googl=
e.com> wrote:
> > > > >
> > > > > The task_euid() method is a very weird method, and Binder was the=
 only
> > > > > user. As of commit 65b672152289 ("binder: use current_euid() for
> > > > > transaction sender identity") Binder doesn't use task_euid() anym=
ore,
> > > > > so we can delete this method.
> > > >
> > > > Given the problems from last time, it seems like it might be pruden=
t
> > > > to let the commit have some time to "breathe" in a proper release, =
I'd
> > > > suggest merging this not for the upcoming v7.2 merge window but
> > > > instead waiting for v7.3.
> > >
> > > Sure, that makes sense. I'll resend after the merge window.
> >
> > No need to resend if there are no changes (see below), it's in
> > patchwork and I'm tracking it so you're all set.  I'll send another
> > notice when I merge it.
> >
> > > > > My suggestion would be to merge this through the LSM tree.
> > > >
> > > > That's fine with me.  I'd also suggest updating the commit descript=
ion
> > > > in patch 1/2 to indicate that binder is no longer using task_euid()=
;
> > > > it currently reads like it is still being used.
> > >
> > > I guess this occurred because when patch 1 was written, it really *wa=
s*
> > > still being used.
> >
> > Yeah, I understand the world has changed since patch 1/2 was written,
> > which is okay, we just need to update the commit description ... which
> > should be a trivial task.
> >
> > > Perhaps we could pick up only patch 1 now since even
> > > if we run into problems and Binder has to go back to using task_euid(=
),
> > > clarifying the docs is still useful.
> >
> > I assumed that was one of the reasons for splitting the changes across
> > two patches (reverting patch 2/2 leaves patch 1/2 intact).
> > Regardless, we're at -rc6 and with patch 1/2 being purely a comment
> > update I don't see an urgent rush on this, especially considering that
> > if I did pick it up now, it would be for the v7.2 merge window and the
> > binder/current_euid() change will ship in v7.1.
> >
> > Let's update the commit description - you've got a couple of weeks to
> > do that - and then we'll merge everything once the v7.2 merge window
> > closes.
>
> Sounds good, thanks!

Just wanted to check in and see if this is still on your todo list?
No rush, we are only at -rc1, but I was reminded of this while merging
other patches and just wanted to check ;)

--=20
paul-moore.com
