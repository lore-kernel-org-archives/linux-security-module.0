Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83A22170B;
	Mon, 10 Mar 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611876; cv=none; b=HhdDo4ScN2GWpjUZzKWFTifYhbN/JsOMVTAAjPrnL5DO8hoos9lWVHWw2I4ksws1Xr/8JoAzhYfcmg7cgx31JZwZJ4HPVyVlnRkQN1Tfz7pYXJaUNknILCAD9wWIdX0/qiakaMvy48C4R/7UczXOluEIZQgzvvzqfdNOH7ZpKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611876; c=relaxed/simple;
	bh=MRIqdJjth7q4rC+R2rNFK723Fwf8fSj4srhXO5Unusg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3ktQFKWm/HKaIeaYNdKIgFpj3Oc24uA1XGJ7D/dpRIXkDFQBGpvHH7auXOhJkUh87kMOdvk4ClFgDcRYL2nxB3HCFXn/FvbpT+zAhXAs/BUklKHe7+cOHReue5gIgJ0mEK8Rn+jzoz/OGtdkO0lIq6kCBoEBNK6ai7UeWfeTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM+SNotq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM+SNotq"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so22783301fa.1;
        Mon, 10 Mar 2025 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611872; x=1742216672; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3K7OcR09rEfJh9DFN1wj/M3SwMYinK3/xaauKUodjYw=;
        b=iM+SNotqfAc+FDNKLdTtPpswlt8hzkm11rtBCFPfZ4lM1wTcO4HwzqKul8p0MZg4ZZ
         A0LZ5ggeD/vzkrh9uOqsWyhf4BgdLojoJYrDClLFFEHEdLaWdwvvWSJdeMIwDiemiRxA
         FDS7bksWmUtM93brUSyrdsi7awZ5IGgLsNXHFJSye8tVu2jFq8dkjrN0iDcl/YVcNXtB
         4U3muRh1LhV5CJLHOTdFs8vjnI6Zws0vDxW+4xRTGzxCWNZv9y0MnfXpzvbliCkaiAJw
         JlWBLYLIkSqmIqlFDSt8JfwZxzb5QqBB92oIPJn9HNxL7AMX8Sl1xKMv6cvQ+IbJ2kGc
         IRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611872; x=1742216672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3K7OcR09rEfJh9DFN1wj/M3SwMYinK3/xaauKUodjYw=;
        b=BXSSN3QS7mqAdkMmOfVvgUZGDlw56z1zWZKH4oeyCp52/yj+5vk0/8K1yyOJLCpxve
         KVO36Sao31dd8t6Rsmjy5R0ECR8f4nl7krPVWaClR2//WZ++rvWKj4K4fjmMguJGVqtY
         mlMUE0M6DA1rwRXIc4W+hCJPmWBQ4Vk8cEKmL+KqTVoKtMNc24D3Ayzywc9eyDxv1GTd
         7hR+P0ooNC/7UrmYq78PTd4xXgLWxSDjy4l8P83piF+DeNkzD7t2CzWkhKsXXLOOfJ/t
         Hp1PAdvTa7aH53K5JWWNPDYVbYLLMQjjZBoauf6c84aa+r2xffshsBOTWnAW6QAqwawT
         HSZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU96dpnwuFYiA3piI+PWzY2FN/9RfYaRGXfHu3nTnAbHuizc+3UbisVPDspJMHYagUOX3zIME7kemI/OsA=@vger.kernel.org, AJvYcCWV6CiS4F/d4XhP5iLDJSHrcxYh8FAYFVGkKWAcIp9iDMoeOOvrhS0E8Yx719ZVFgpLWLVFDsrCPsT72B/3WwHoxAokwKSI@vger.kernel.org
X-Gm-Message-State: AOJu0YzUdFbeBz9jDPFz4D0m24GOai4UErHna0z8W68HQC7ktueQdtlw
	vKFj98jwp+XUpDG8CB7mttTKZ0Lq2wFk7z+m0YBbJxyrbjfJC4gJ
X-Gm-Gg: ASbGncsuz5a+4LKQN4Kh/+EH1OZhz79nYXmNXR2PUiqqgA8z3qWRbUlTswKTZu5KnO1
	3JBtiGzQW96rSxKDx03JiNXcWJuHboHALC9ybJcteBwXn6wr4DfBpc3dn13L+s0OPCLv7jEe4kC
	Bxoqqli3WqmN8ozaADsny4N61QoFMajSb88uxXLa42ixLlhg54yvx8L5TYlScbmJjz0qaoW8e2x
	Ty2sJn2duh0Gb3Fkx+xPfJata2PIY8O4x7afvsRzTmgu50m8jDIDfcikABF9w6sYzn+NzlEsoi/
	3Ur7Do75dV8bLLqP21hOtsn92G2E0tzxVb3u0sHjZedQrblP/xv5
X-Google-Smtp-Source: AGHT+IEdfHviVl8qv73NLqnbG5LMKxIjf1w+f+nIk6opcs2/kJ6jxk6indLGkIKxAROrKC0+KlNNuw==
X-Received: by 2002:a05:6512:ba6:b0:545:a2f:22ba with SMTP id 2adb3069b0e04-54990ec1b80mr4453322e87.37.1741611871880;
        Mon, 10 Mar 2025 06:04:31 -0700 (PDT)
Received: from localhost ([2a02:168:59f0:1:b0ab:dd5e:5c82:86b0])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac2523d940csm641944666b.178.2025.03.10.06.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:04:29 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:04:23 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	sergeh@kernel.org
Cc: David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	Peter Newman <peternewman@google.com>
Subject: Re: [RFC 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20250310.990b29c809af@gnoack.org>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
 <20250221184417.27954-3-gnoack3000@gmail.com>
 <20250227.Aequah6Avieg@digikod.net>
 <20250228.b3794e33d5c0@gnoack.org>
 <20250304.aroh3Aifiiz9@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304.aroh3Aifiiz9@digikod.net>

Hello Paul and Serge!

On Tue, Mar 04, 2025 at 09:25:51PM +0100, Mickaël Salaün wrote:
> On Fri, Feb 28, 2025 at 06:33:55PM +0100, Günther Noack wrote:
> > Hello!
> > 
> > Thanks for the review!
> > 
> > I'm adding David Howells to this thread as well.  David, maybe you can
> > help us and suggest a appropriate way to update the struct cred across
> > multiple threads?

Paul and Serge, since you are volunteering to take ownership of
credentials, maybe you can advise on what is the best approach here?

To summarize the approaches that I have been discussing with Mickaël:

Approach 1: Use the creds API thread-by-thread (implemented here)

  * Each task calls prepare_creds() and commit_creds() on its own, in
    line with the way the API is designed to be used (from a single
    task).
  * Task work gets scheduled with a pseudo-signal and the task that
    invoked the syscall is waiting for all of them to return.
  * Task work can fail at the beginning due to prepare_creds(), in
    which case all tasks have to abort_creds(). Additional
    synchronization is needed for that.

  Drawback: We need to grab the system-global task lock to prevent new
  thread creation and also grab the per-process signal lock to prevent
  races with other creds accesses, for the entire time as we wait for
  each task to do the task work.

Approach 2: Attempt to do the prepare_creds() step in the calling task.

  * Would use an API similar to what keyctl uses for the
    parent-process update.
  * This side-steps the credentials update API as it is documented in
    Documentation, using the cred_alloc_blank() helper and replicating
    some prepare_creds() logic.

  Drawback: This would introduce another use of the cred_alloc_blank()
  API (and the cred_transfer LSM hook), which would otherwise be
  reasonable to delete if we can remove the keyctl use case.
  (https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com/)

Approach 3: Store Landlock domains outside of credentials altogether

  * We could also store a task's Landlock domain as a pointer in the
    per-task security blob, and refcount these.  We would need to make
    sure that they get newly referenced and updated in the same
    scenarios as they do within struct cred today.
  * We could then guard accesses to a task's Landlock domain with a
    more classic locking mechanism.  This would make it possible to
    update the Landlock domain of all tasks in a process without
    having to go through pseudo-signals.

  Drawbacks:
  * Would have to make sure that the Landlock domain the task's LSM
    blob behaves exactly the same as before in the struct cred.
  * Potentially slower to access Landlock domains that are guarded by
    a mutex.

I'd be interested to hear your opinion on how we should best approach
this.

P.S. This is probably already clear to everyone who read this far, but
the problem that creds can't be updated across tasks has already lead
to other difficult APIs and also bleeds into user-level interfaces
such as the setuid() family of syscalls as well as capability
updating.  Both of these are solved from user space through the signal
hack documented in nptl(7), which is used in glibc for setuid()-style
calls and in libpsx for capabilities and Landlock's Go library.  If we
had a working way to do these cross-thread updates in the kernel, that
would simplify these userspace implementations.  (There are more links
in the cover letter at the top of this thread.)

Thanks,
–Günther
