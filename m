Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406027145C
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042847; cv=none; b=X/n5WgRhsKv0eHD7Ob18PrHKEZcXtYNV+GLU3GDeO/Vz6Pstoegf+U+wuEgiHLmzOheZm3mK3oFuwMrYbRkWpoqDRDw+uDEA+mGvUNf+dXVHe+NB4lYQpxYxJC5py8gm7SGVNBkmLBM0x/wTStXL9+NV4d+0RXBP0kaBmwpxPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042847; c=relaxed/simple;
	bh=q9saZzPxKQgNmhZe1nTPbgY4fDxl3Xft1oscVp8TQKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0CmGOxw+tEmG3OhYvouzvGQCBiNtQ0tDDCWOsON0AnPFSZOxPl9P9+jPcqO6yghMM8wj51agy4iW68evtjbs1WQY9av7/z1QPL4Pe8JDjkE1m2FOBlpF0eVZzD4lCq0NM7t5BX99+nU1kA4W7p3aiDNiSVxWzwZiiC3Blttk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V+HOenhW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V+HOenhW"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-330631e534eso1617092a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 Oct 2025 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760042845; x=1760647645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6K/zr+mhgRMW1dEHBSBrEj+cHx1AJJEsB7Xi5fFruA=;
        b=V+HOenhW1D10V5BvnlJoRBteyJanDQugh+2TZIC6oFcES306iSSVzfX5s9RpcVKmNR
         hgl4/uuiOMkTR89DAfok46sekE3MC/gAa49JNM4Y9S6eVDjgBi3peGlRkKvgmX4+Gugj
         VGpnR6nqEdDK0TtvVLbmwDp+FYmaeH7ZAT4MshntwfTEsyFqTt/36k05RU7Awdcah5g3
         zvjU8fPbtvGBOJXXIyGqQSYN2/HNQouVdtLTXcVFreEkmQL7E2eNQ53e7+qdMM8r8vNd
         fDIExpxMWI3SvItzBwTTg0dSUZBktTAfwD0Bo/MT+6lwb6/FfhK9CvvJgDKObEapDKxm
         cx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760042845; x=1760647645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6K/zr+mhgRMW1dEHBSBrEj+cHx1AJJEsB7Xi5fFruA=;
        b=E2QYCTvbli95PYK/d2vbBms+mFy83TtWkJqJJxbU45DhTTLoyePOnDqCGKnQlPDbtt
         C37vn8/CBndecPM9JB/xrn2382V/pVaQ+K3UxMU1pelWkNigAihCkt45dDVsx2txRQ2S
         LmCkPWHa7uRLslRg0+8lZiyoiSCGGo586qUpDp1upRA2o2fjMQtu8qE7Rb9tCK94exRB
         YVWjtERC8Xk3WRRUPRXwFxbhoMy9lMmI3j6qdp0ZcVxYyqS2vPBHsePgJNXpa595jNw9
         vhLpc6Vi1LJpTL5Ui2MelPurKrS6VHVCNeqay7CkO2XRY0laIZJiAZHc3dcxoy718OqK
         8Nzg==
X-Forwarded-Encrypted: i=1; AJvYcCWUVur/zUVSSrqSMLptEd/QMMp4fw7a9cg8ORhEhX4FUOFwDUOLhBwkmrEHZYSVflOE2EgrnOiK/r5F99wDLvR26FliAOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJgNbgrnSYMZ1hOc9Nae3iHh6Wc25TgPzZx+labbkortJPWXR
	aK4wNwlE3MA0QzhMi1Fv1kva4JGfH6UeTN/7dzf9rnd094mrn78bm1YABR31nRuMZrpElAeDwoD
	HcQksub/8o8/tCBCG1TM7vcH9h+K2GYBqBF4Z4JV3
X-Gm-Gg: ASbGncu8TPamrh6prkxYi0Z2dul5NZuy+eZsAeoxMa4trEuIiZFeikdZGwWFNW2GJKm
	JO8MUsdOZ8E+CyCBOnYjhDjUCv2htn46PfeemI9OjY3nmnE9iN2oS3h0puG2GOyiIz6zEWv0Bk2
	woTDl5Fcm6HK0sbqmrm1OgYYtIFmU1m4Qpk31VprqtG7ZJko6AIdAQscz+I1VaGaE+JaB6V3BGM
	6YNl5RLOtgCqoraomexjUTpCJp8CjI=
X-Google-Smtp-Source: AGHT+IHwcV2uuUwAl2OswF6usdNngeVHs1OU6Qv4WDIoDMFlQQoJQ6qMYB4lYZ4rU5CeU4FuempUIEnPg0uLmZuIgiE=
X-Received: by 2002:a17:90b:1d8b:b0:332:793e:c2d1 with SMTP id
 98e67ed59e1d1-33b5139a37amr11731621a91.36.1760042845003; Thu, 09 Oct 2025
 13:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com> <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
In-Reply-To: <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Oct 2025 16:47:13 -0400
X-Gm-Features: AS18NWArdmWPZMqLgFQiddXgH5voBO_n-fQZZPwVAAdYJ003C0ZIeYDQyt1C9GA
Message-ID: <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: ast@kernel.org, KP Singh <kpsingh@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, james.bottomley@hansenpartnership.com, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, kys@microsoft.com, 
	daniel@iogearbox.net, andrii@kernel.org, wufan@linux.microsoft.com, 
	qmo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:53=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote:
> On Mon, Oct 6, 2025 at 5:08=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, Oct 3, 2025 at 12:25=E2=80=AFPM KP Singh <kpsingh@kernel.org> w=
rote:
> > > On Fri, Oct 3, 2025 at 4:36=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Thu, Oct 2, 2025 at 9:48=E2=80=AFAM KP Singh <kpsingh@kernel.org=
> wrote:
> > > > > On Wed, Oct 1, 2025 at 11:37=E2=80=AFPM Paul Moore <paul@paul-moo=
re.com> wrote:

...

> I feel we will keep going in circles on this and I will leave it up to
> the maintainers to resolve this.

Yes, I think we can all agree that the discussion has reached a point
where both sides are simply repeating ourselves.

I believe we've outlined why the code merged into Linus' tree during
this merge window does not meet the BPF signature verification
requirements of a number of different user groups, with Blaise
proposing an addition to KP's code to satisfy those needs.  Further, I
believe that either Blaise, James, or I have responded to all of KP's
concerns regarding Blaise's patchset, and while KP may not be happy
with those answers, no one has yet to offer an alternative solution to
Blaise's patchset.

With that in mind, I agree with KP that it's time for "the maintainers
to resolve this".  Alexei, will you be merging Blaise's patchset and
sending it up to Linus?

--=20
paul-moore.com
