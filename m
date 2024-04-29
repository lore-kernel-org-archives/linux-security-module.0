Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBC29421
	for <linux-security-module@vger.kernel.org>; Mon, 29 Apr 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385434; cv=none; b=UdlUP9rkFENmMW6sjk3f+52JaU9jwJfwO5OCCE2+t7fj/qDgLjf5hX7t6GUL2Cg4wznpjquC7WlgKw1ZQiaH6q54WBBOTadSNS8Fwkpz/uLTkzU6q5m+Pg6es3ZC8DL7rS7beDEGiB5txNbCrowvFwdn4vnRHTmaMxGy2StU42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385434; c=relaxed/simple;
	bh=xQ7hNCE0DNOP4U41pP3s0ClJGxIz6zSi+Jgjtu12jcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TPEHVTRBjmRNPoLbZ9NEkwQspnkV62p5H1XR6k0XJcPdhLa20wHDS0JJAWb5p9631+IH7uQ7MmSx3GrOGPDzNWW2sxVbYYDC779WH+f/5qkYX3tHJbqwRaIbt102A0oBaLb4irTJ3cwMK5tWjXXu6xIPNwvtvV+ZwkmTrh1UkJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPa4eoP0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPa4eoP0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrFSV+enroO5/Kb8/GKX96Hz0vjFPPsWJvTVuF9uIxc=;
	b=jPa4eoP0E/NegVsPaF+d+vy+tvP1EtHAt2VAkl5jvU0YgojLqIz+L87/4Cahy6aeMRm9vK
	TfaokII+1r/nbOkXsprwhAi3xsOwN3dgjQCEaBtauhNftcniWxarVpDLxmKltxATT1BYas
	9RFmuOyI8BHhotjCSQpZXMQY0ePoCp4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-cyzpw45oPrS2KvuIu5NO-Q-1; Mon, 29 Apr 2024 06:10:30 -0400
X-MC-Unique: cyzpw45oPrS2KvuIu5NO-Q-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ee1421ce19so1780302a34.3
        for <linux-security-module@vger.kernel.org>; Mon, 29 Apr 2024 03:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385430; x=1714990230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrFSV+enroO5/Kb8/GKX96Hz0vjFPPsWJvTVuF9uIxc=;
        b=D23REpKMikjXxkxrtHkKRQ3qYlzLnQhJl1XUnKex/7jg/NVYvQw9kMHwTvTENtFpHu
         0HkRTQLxxu65fxyzJ43SVCtEv4yE0PEsoiq3718r9oErBNJ8WmDIn2oQTL7tXxvm27bn
         SfWXF/N696Wegg7t0SsQ44bRTOT93oVUrAnvp/Pc0pMGSNoSit8gul+xroxjVaVdJkKm
         dxe3i80Jt92SYR9krSISdoKQZzHlahDvkAd8eGD+j+pgZArY0FJ1NMVdg1TlfL3apThW
         4tSw/io5EQomwR4p8IQYgkixMVIHlAlacYbUHxNGcxt3VxLZWKmVAG98u4yYMUM7VzfY
         1PSg==
X-Forwarded-Encrypted: i=1; AJvYcCWUPAPedXB+nJinkKSWP1PIS+v5CKwpPs7MuOd3KO43Ax8Zq2ra5E30jkD7SQoe0pJTa4jApsd+75uHi6LqBQfkArP7f0UY55mzONZTzFQGjTk3lJbq
X-Gm-Message-State: AOJu0Yy/pFBCtitPBW2ra2gexXrfEOBhBPPVSB2TnExU0RvVaF5PPWl8
	stkWNTj6wRd0TUCpzAo6mI5Jn2UCnS1xMEC2svI7vF+zPioLi6CnSNGbvS+dbuyjV1CBU5Nw4a3
	pQyIVnzZBFLyEyuTAKSES/UiczGSteAATs3Sb6X+S5DFkSM1bG67CX0MXDFrHBgrUdosP3ThsQw
	==
X-Received: by 2002:a9d:7991:0:b0:6ee:2ca2:4370 with SMTP id h17-20020a9d7991000000b006ee2ca24370mr2789815otm.15.1714385429719;
        Mon, 29 Apr 2024 03:10:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrvfVsOcM4emYdUYKViS3N6+afe+LNkfiEGNb0K0Zlc2Ov17BGL5mY6doHoVFVADHAZxJpjw==
X-Received: by 2002:a9d:7991:0:b0:6ee:2ca2:4370 with SMTP id h17-20020a9d7991000000b006ee2ca24370mr2789795otm.15.1714385429234;
        Mon, 29 Apr 2024 03:10:29 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a034300b0078ef13a3d9csm10354459qkm.39.2024.04.29.03.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:10:28 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:10:27 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH v2] netlabel: fix RCU annotation for IPv4 options on
 socket  creation
Message-ID: <Zi9yE099IYtqhCzN@dcaratti.users.ipa.redhat.com>
References: <c1ba274b19f6d1399636d018333d14a032d05454.1713967592.git.dcaratti@redhat.com>
 <b6f94a1fd73d464e1da169e929109c3c@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b6f94a1fd73d464e1da169e929109c3c@paul-moore.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello Paul, thanks for reviewing!

On Thu, Apr 25, 2024 at 05:01:36PM -0400, Paul Moore wrote:
> On Apr 24, 2024 Davide Caratti <dcaratti@redhat.com> wrote:
> >

[...]
 
> > @@ -1826,7 +1827,8 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
> >   */
> >  int cipso_v4_sock_setattr(struct sock *sk,
> >  			  const struct cipso_v4_doi *doi_def,
> > -			  const struct netlbl_lsm_secattr *secattr)
> > +			  const struct netlbl_lsm_secattr *secattr,
> > +			  bool slock_held)
> 
> This is a nitpicky bikeshedding remark, but "slock_held" sounds really
> awkward to me, something like "sk_locked" sounds much better.

ok, will fix that in v3.

[...]

> > @@ -1876,18 +1878,15 @@ int cipso_v4_sock_setattr(struct sock *sk,
> >  
> >  	sk_inet = inet_sk(sk);
> >  
> > -	old = rcu_dereference_protected(sk_inet->inet_opt,
> > -					lockdep_sock_is_held(sk));
> > +	old = rcu_replace_pointer(sk_inet->inet_opt, opt, slock_held);
> >  	if (inet_test_bit(IS_ICSK, sk)) {
> >  		sk_conn = inet_csk(sk);
> >  		if (old)
> >  			sk_conn->icsk_ext_hdr_len -= old->opt.optlen;
> > -		sk_conn->icsk_ext_hdr_len += opt->opt.optlen;
> > +		sk_conn->icsk_ext_hdr_len += opt_len;
> >  		sk_conn->icsk_sync_mss(sk, sk_conn->icsk_pmtu_cookie);
> >  	}
> > -	rcu_assign_pointer(sk_inet->inet_opt, opt);
> > -	if (old)
> > -		kfree_rcu(old, rcu);
> > +	kfree_rcu(old, rcu);
> 
> Thanks for sticking with this and posting a v2.
> 
> These changes look okay to me, but considering the 'Fixes:' tag and the
> RCU splat it is reasonable to expect that this is going to be backported
> to the various stable trees.  With that in mind, I think we should try
> to keep the immediate fix as simple as possible, saving the other
> changes for a separate patch.  This means sticking with
> rcu_dereference_protected() and omitting the opt_len optimization; both
> can be done in a second patch without the 'Fixes:' marking.
> 
> Unless I missing something and those changes are somehow part of the
> fix?

just checked, rcu_replace_pointer() can be used also in the oldest LTS
but I'm not sure if kfree_rcu(NULL, ...) is ok. I agree to keep
rcu_dereference_protected(), and the useless NULL check - I will
follow-up with another patch (targeting net-next), after this one is
merged.

--
davide

