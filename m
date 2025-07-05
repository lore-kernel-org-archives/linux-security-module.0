Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DB13AF2;
	Sat,  5 Jul 2025 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751730466; cv=none; b=d30JMjfiTmoK4fvS2e08J94N2hEW7/QCZpzRPqoacBYIU8P6DNwjYK6xfOeNvHULBa5vydL23YFoGl8zK13obz5TIJQTEU82qwlJ8av1CRfI6SXkwUgXKBRogO1vE8/plIhlgBmrgmjsJqaukWLdZxpCBp2xIM1LZwHqLLbV+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751730466; c=relaxed/simple;
	bh=vyUpJ8U5I1H58q7TZ+Vtjzg4LYM0H7CTUmnVVDYADIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWKQ7JEcp9SDIR9KVXNA2wiq3CNF+u8ZOr4GaEUvwr1e1X4wjvG/fiTFPZ2R4tN27oTNitSL+n51iB3UqHxR5ICsxY74QIi3cBaFJLakL0kM9m3F4Hi0dN5YtP19/NUsSYszCGm44kU/tfMNSEk8l52nqqn15qvhEmavngDWa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso1681346f8f.3;
        Sat, 05 Jul 2025 08:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751730463; x=1752335263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvzZHRS10n6gPJcrQt50+YuXzFjvi7jvCWV0Ug/gAc4=;
        b=AS47nEI1asdo/IEttErDV2uGHLjtaeHsUcdk3Eak9jIV+Cutdk99LAFiPXbB4Hbk71
         fBYAEYNRXPOzX9ekvU/HunXiozdqTaFDRzDP0L382ySfbL+69GZpbAa3cuxA2csrhUd5
         s9LXxZ1tpYbP5ZBU2JwGSsRVhLd0kRibpLYdRokxiwfdPyG3/8ioSkqa59YDMd8/9uKq
         l8EF1Tlp82TxAlr1PwqbOGhMlrpf1//G6UUS6+ZRqZQAr6mIDqNjBxZM9g8PFc//WpVP
         cb0kzqDSjqvPiOP42Y3jbO09nIoFQ/6M+8Dmz+xl+SZ1UANi3Lh1aWpa0Tkl0p2hRdYY
         ZXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVVii2ACjZ7daXk/R0xtXNFlsiyp6nKNcxfXAcmAdc+JoseWzmJduVbXVPDVcqPqhTr37DvGp5VzsAvAo=@vger.kernel.org, AJvYcCUi21YPcKjUvt8BF8NB8t5hizlGrLuFbO/KY72hxV3xf6TO9D8VhSw0GGDwLjVANKk74xsILLPV7ltiv4YAKW7nveGWylTO@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXTYzuxNmWcyEtOOW89TUnxqECy092EIkUuSleqFdfe7tUqhz
	GOjqjQoqOVjhY7mPy5ZHWjqC5Y74iRI+iO4fzf5ZLNoMep0oayPuqpTphwgDtg==
X-Gm-Gg: ASbGncs1iTYNr5afgiKI6j6pTmf9EFWCaTL/jY0tMgeStiqK9EpF517eK76IaSA7x0g
	in8691HrV5Im8SIEHtBZyCisYAaSjvby6utyNkahIBj0+5kTrXmfaBh+RunWc1uu4NWvvPl820Y
	7d/9IjktrDTi+P6TAt/V95bjjqdLYEDsjS9tkVVSkEbX+fyRLntkGHMSuy/XnpScGpus/DAj4DZ
	yQi7KYqOcUYyclxMy1bPUEQ3RH6PmBz4zJoPXp+kKfyDG1GVfsNKjGQijCw+r+7RAoMHYqeo9Eb
	HByPstOON9X0Gr222etcKfTVr6mPsRd4Z9Jbkkxb11kRu9jFjOVumHU=
X-Google-Smtp-Source: AGHT+IFC6PD2S7C+IpJQApuX+Vr/n2BZjoGXcohTLrFEW10KTcFBQtU//5MYM95EjMK+peeV/Ii0xw==
X-Received: by 2002:a05:6000:4911:b0:3a4:ffec:ee8e with SMTP id ffacd0b85a97d-3b49aa742a8mr1886942f8f.36.1751730463041;
        Sat, 05 Jul 2025 08:47:43 -0700 (PDT)
Received: from gmail.com ([94.3.218.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b46d4c8619sm5276812f8f.0.2025.07.05.08.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 08:47:42 -0700 (PDT)
Date: Sat, 5 Jul 2025 16:47:40 +0100
From: Breno Leitao <leitao@debian.org>
To: John Johansen <john.johansen@canonical.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, James Morris <jmorris@namei.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: apparmor: WARNING: suspicious RCU usage
Message-ID: <aGlJHJpMk__IHNKp@gmail.com>
References: <877dfa72hm.ffs@tglx>
 <4dbd0e0d-b1a3-8a06-5f65-bdcbb76fccee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbd0e0d-b1a3-8a06-5f65-bdcbb76fccee@canonical.com>

On Tue, Sep 21, 2021 at 02:23:19PM -0700, John Johansen wrote:
> On 9/21/21 1:32 AM, Thomas Gleixner wrote:
> > 
> > Running with CONFIG_PROVE_RCU_LIST triggers the following splat:
> > 
> > [    6.805926] =============================
> > [    6.806848] WARNING: suspicious RCU usage
> > [    6.807738] 5.15.0-rc2+ #24 Tainted: G            E    
> > [    6.808860] -----------------------------
> > [    6.809734] security/apparmor/include/lib.h:191 RCU-list traversed in non-reader section!!
> > [    6.811508] 
> >                other info that might help us debug this:
> > 
> > [    6.811516] 
> >                rcu_scheduler_active = 2, debug_locks = 1
> > [    6.811527] 2 locks held by apparmor_parser/1897:
> > [    6.811530]  #0: ffff88885f139450 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x68/0xe0
> > [    6.816110]  #1: ffff8881000578a0 (&ns->lock){+.+.}-{3:3}, at: aa_replace_profiles+0x16d/0x11e0
> > [    6.817418] 
> >                stack backtrace:
> > [    6.818086] CPU: 38 PID: 1897 Comm: apparmor_parser Tainted: G            E     5.15.0-rc2+ #24
> > [    6.819359] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> > [    6.820536] Call Trace:
> > [    6.820918]  dump_stack_lvl+0x57/0x72
> > [    6.821499]  __lookupn_profile+0x193/0x1a0
> > [    6.822461]  aa_replace_profiles+0x395/0x11e0
> > [    6.823448]  policy_update+0x13f/0x240
> > [    6.824326]  profile_replace+0xb1/0x120
> > [    6.825213]  vfs_write+0xe4/0x3b0
> > [    6.826027]  ksys_write+0x68/0xe0
> > [    6.826576]  do_syscall_64+0x3b/0x90
> > [    6.827099]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > which is pretty obvious because aa_replace_profile() invokes:
> > 
> >     __lookup_replace()
> >       __lookup_profile()
> >         __strn_find_child()
> >           __policy_strn_find()
> >             list_for_each_entry_rcu()  <- Splat
> > 
> > The code is "correct" as this is the writer side and holding ns->lock,
> > but it's incorrect to use list_for_each_entry_rcu() without being in a
> > read side critical section unless it is properly annotated.
> > 
> > Same problem in the same function vs. __lookup_parent() and there are
> > more issues of that sort, e.g. vs. __lookup_profile() in
> > aa_remove_profiles().
> > 
> thanks Thomas, I look into it

I just hit this issue as well, and I got the same feeling as Thomas.

Quickly looking at the code, I think you need to pass an extra argument
to list_for_each_entry_rcu() that the ns->lock is held, silenting the
warning.

Maybe being able to get "struct aa_ns *ns" in __policy_strn_find() and
pass a lockdep_is_held(ns->lock) might be the most straight-forward
solution.
