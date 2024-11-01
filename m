Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B71A08C2;
	Fri,  1 Nov 2024 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480645; cv=none; b=adveML0uSG7QY+ECuhZtqECnFTPvqrPdPIqxLPAU0yk25X6fSR+N1+0bvlQk5IMWrWFkPO70sNoSHOHX0a+8SuibOfgpgXfAiEGpQQHXKWW1Ks8SSdIHhyzB6Th6uBTSKn+iq0w1b3CcMpdiEf9uLqiGKCsQzxeUZQnWfEpFwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480645; c=relaxed/simple;
	bh=G7YUAtokdu7yRwuXFCob7ys8rE/bsipsEJCIqPG5sSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCi3SvJ5shiwM3rrowmqaT1LiFKEMZCTwklnq/m8sOaeM6TXZKqWOWGo6uNRYI78VEhpPX5FqfKPertSbHWitR8VkxmWM3CFjE1lVNM/9G4dF3ayi2t4OVTJqv3YXtF4bSB0tr+zNNlyiK+riFrEe3UE+w+Uqv0JIrXb3uICClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBLkIQQN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBLkIQQN"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea6f99e6eeso197704a12.1;
        Fri, 01 Nov 2024 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730480643; x=1731085443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBfjrQjC+K3XRUNkllYf81cyTHRDd6nddEiHrej+VtI=;
        b=WBLkIQQNcnM26GBmLykHX4pFd5hl+QV9z/oy27BGL2pX/odFmIMYX17OmLJpoI4NLb
         yQ11ebxDiyjJikbb8Ps2k5TpfG5L8Bvv6YONp3c1w6pZwwVI208FgidwdxUQJ996l7hE
         GFLZYo88TMVFr5oQ5OMWXp0Jd9lWn+xaofuICtEpTAf06gJRZkmyLwieqYOlsUFNl3Mh
         4IOJi305glIOSqMZS75tHE5GYuvoCkSE8tic0WwJ+UaDBoRIBRbGzwjuoadxG/qmq2wX
         Brf5Vs2Jnl8SJjRpwFVHHO8Pcv0AP6s8KG3Sq1eVy0YnE1LRyz7nNJtqDdur5h9m5zRx
         z9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480643; x=1731085443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBfjrQjC+K3XRUNkllYf81cyTHRDd6nddEiHrej+VtI=;
        b=fjm0jFzuJyq8vhxrlIdP81biHQ5vEXAKQZ7vSwgLRlJAU5GSKQ/8y1Ln+hzZwX77iQ
         TRfsWOkdHwiAt13wFFx1UpbjaRFoOA1dslevtaig562ARqDL3Jj0Ak+51j+1Tmk6CRqt
         flLQ87XGkWx3q1qaarYxK6Od3FNbbhOxr818ezVWkOrZo2REjeJhmngg3XIwg93pn8ZI
         ZAqxNi+kD5HhRYrgnmLfLdPKrSL7h7XekGRAJ3CzedLDYaQzK//QWBHdJDZrIazVnqjL
         aHUaWM9fBC3lefv2N8/FW4JmpI79DkTD2YtF/z46L5l7O8oKcqaKThHceiTmrDXsjXOk
         pJZA==
X-Forwarded-Encrypted: i=1; AJvYcCUeZk+27K0qCSWIwJeuKSBAhb1/cnOKhcILyPQOLBzIp5p7TweA0eMjVTnbqFqmYVGu4MCUNS1oUKSTHxJsUxcgwSJ1aldY@vger.kernel.org, AJvYcCVsk7syWg9C6b6LAEqGNwFfmYyrWi5wTEbmPHeuu/h2BARJWtY78dbZWtJH2A2GqS5hRecwRGFHKtlv5uc=@vger.kernel.org, AJvYcCXPGseUEs5MNJw96vQdOM0BZYaZ7AdM761fgfbq6P6/Xl5Ba1BAyxhdBlFbiGI8io6fY90Ipb0zrmjBbOEhkpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwN5rtNVpv9Uri6sYA+UveHIhQZWWnuhfBdy0w4AJ6nY20DRK
	EkA4Kyh4aoON39rlb4NkW0PlDLa3Sem/HljRBxrWFbMZlgjXQ+SgKNvmJvcMdNUBsihYSwVgXEc
	xrNEj/WuakTf48hupYZ3pXfoczbM=
X-Google-Smtp-Source: AGHT+IE989mVcGbFzSXUTNEne5q6I3f881GzwGh8vhKMnckzkFdiEGpT2eiUs8ItoTop4yVyd0Xz2gGTKnuMyPDuFbI=
X-Received: by 2002:a17:90b:3b48:b0:2e2:c423:8e16 with SMTP id
 98e67ed59e1d1-2e8f0f4ccbdmr11862428a91.1.1730480642714; Fri, 01 Nov 2024
 10:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv_Y2tzs+uYhMGtfUK9dSYV2mFr6WyKEzJazDsdk9o5zw@mail.gmail.com>
 <20241101095620.2526421-1-aliceryhl@google.com> <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
In-Reply-To: <CAHC9VhS5wLQeF4LX67UgUYVG3oViA7CmSZS_kugH+M5J0XS2Vg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 Nov 2024 18:03:49 +0100
Message-ID: <CANiq72kcvpEqpwFTNFmxfJsfBMeBNiDrrvFBf_iS7+ozaECJzw@mail.gmail.com>
Subject: Re: [PATCH] rust: lsm: replace context+len with lsm_context
To: Paul Moore <paul@paul-moore.com>
Cc: Alice Ryhl <aliceryhl@google.com>, naresh.kamboju@linaro.org, casey@schaufler-ca.com, 
	anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	dan.carpenter@linaro.org, kees@kernel.org, linux-kernel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, ojeda@kernel.org, regressions@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	lkft@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 5:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Thanks Alice.  Would you like me to pull this in via the LSM tree with
> the associated LSM changes, or would you prefer to do this some other
> way?
>
> I'm going to merge this into lsm/dev for now so that we fix the issue
> in linux-next, but I'm happy to drop it or do something else, let me
> know.

Christian has the VFS side, and both are needed for this -- do you
mean you will cross-merge vfs' branch too?

By the way, merging both vfs.rust.file and lsm/dev I confirm this builds fi=
ne:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
