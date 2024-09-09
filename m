Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65894188CDB
	for <linux-security-module@vger.kernel.org>; Mon,  9 Sep 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906198; cv=none; b=dzoKBV1g4SxslbOoTXeNk0Vdun4hc1sx/FdAG4PPzWz/6pfkPYikYT0BVzzJ0IufGEHmKbELHV7sNHEy3z9O9SVAMBQbSZc2xBV0U/wUMRgTxuIQ8lCwu9lzhzC5eZGrRzFoL4Wi25sjaHae0frcrsVfzZONP+jy6pJFhtpuddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906198; c=relaxed/simple;
	bh=hRz6Efr91Clx46MD3mExjRxZT8kdCRLBwKtBuEtdgtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVtxx9OtEPko7dwHmSQmiLcH38/757EFJt3kfd4xqL+A/6decNqdujTU5wVkSF6rKWwYlzJWD2e63fbsLj5wEOUyClyy4af8vuJTtoCw0hAdTWefMCBceQthsifTEXwTrhZsOOio+iODSdrhUv5Dc8NYlghKgax55I8yKQxnWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LzDSGkWC; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LzDSGkWC"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a7c25e350so4479226276.3
        for <linux-security-module@vger.kernel.org>; Mon, 09 Sep 2024 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725906196; x=1726510996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgmY0kbaKktLPLiiIRAv0o0U+kqdNewIzcrHSYTxgsI=;
        b=LzDSGkWCw6ER+AXQmVMDGiF1rnJBjMHPeKUsrzO/8o/k2cEsT70a9+SgpMAHMWeUKX
         9AMEhg2JFgO0/RIX79PWdXvdv7kxKcYjBC0TauIw/+65fLlOCGHTjBVmt9JK2+9BZQHO
         xmlFtoNgYVNPfTBr1Q8A30G1+FDHVsF0NLFdeNTKw7cdTSI03pReqCqLZF4i7AWFuL/D
         1Dm1le7bWriyIdDMdmYmecKhAsdRUdijTfLVcQ+r3syKu+/wg4KwvicFPlK6NVWaAne3
         D4aZwoOPcSkGGrp12U0qwZ08Q7N+z7KBae3f2cJsOU8vxlc2p2mgq0SrXzMYDkyQaL/9
         DMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906196; x=1726510996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgmY0kbaKktLPLiiIRAv0o0U+kqdNewIzcrHSYTxgsI=;
        b=JA3PZDJs3TYRQkYX9ifzxKi49jM2RT2nmxhPG3NEUposEJtG5T+/uGtKu2Gnc45MAI
         HiC6ZEppgPasLjLjpQAOt1drVxeVq0u2FFGNZ/nI2ys86aPhHcVq15BcO6HEMRcSjSqY
         +GfYkzc3gHEQ+XOIEE8JuLjGb8tKWEuKaZXg6bKtlmJmvMya70FO/dEvRNOke90hSXui
         /SMZ3baOKTPIzZW8WR20eTN0Jt7Hkq+5zLvnAFmYKylyiQOFo2mwFeNrSO5SolS9BkBj
         rDWxVP4eZVW7QoJnzAm+qCCHNa4cuaOtOIpyqsnL9XviRc/tkts9rj23M6oDVE9NcMvp
         4uNw==
X-Forwarded-Encrypted: i=1; AJvYcCV5b0RpmOKGRAVEbpOwKent8QNrAT6TTZTPORAKcQ2GrajWH+Yj3tnMpEQLqIwPeyTmpJ2tSFz0Knjh7r5L9Dc2ztiWd9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qVp7hpdLEkToX/3LPBnaEFNP4dqVWMuC9DNmkOrr9pSoysn8
	u+8Y9BLIJP+S6pI7y/lEdHvDs4v9iKxb+a/FRMIzdWwA6lukNbxCUrsqrn987KFDfKhVEwPP6uE
	oEaWsgboOClHvwRIOXl11IupwQmwzeVdLdxPW
X-Google-Smtp-Source: AGHT+IElvH7ixPuebP2RKFtUqKOky0nJpjhOYnvJ1gZFGL6UyrqOk2Rx3KyTRAwJBcUPt/io6xI8CnJurxfM3zJ74yg=
X-Received: by 2002:a05:690c:83:b0:6b4:e3ca:3a76 with SMTP id
 00721157ae682-6db44f2df69mr153236987b3.19.1725906196452; Mon, 09 Sep 2024
 11:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQvbKsSSfGzUGo3e8ov6p-re_Xn_cEbPK0YJ9VhZXP_Bg@mail.gmail.com>
 <20240909113535.vomill5z4v5q47rm@quack3>
In-Reply-To: <20240909113535.vomill5z4v5q47rm@quack3>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Sep 2024 14:23:05 -0400
Message-ID: <CAHC9VhRUhVg4Frh1Ms5VRyKAW-kEd62rUsoavDL7oCu=cqYq-A@mail.gmail.com>
Subject: Re: linux-next commit 0855feef5235 ("fsnotify: introduce pre-content
 permission event")
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 7:35=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hi Paul!

/me waves

> On Fri 06-09-24 10:42:39, Paul Moore wrote:
> > When you are making changes that impact a LSM, or the LSM framework
> > itself, especially if they change the permissions/access-controls in
> > any way, please make sure you CC the relevant mailing lists.  If you
> > are unsure which lists you should CC, please consult MAINTAINERS or
> > use the ./scripts/get_maintainer.pl tool.
>
> Well, it didn't occur to me you'd be interested in these changes but you'=
re
> right that we've added the new event to a bitmask in
> security/selinux/hooks.c so strictly speaking I should have notified you.
> I'm sorry for the omission.

No worries, just something to remember for the future.

Thanks.

--=20
paul-moore.com
