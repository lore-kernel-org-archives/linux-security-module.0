Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C923644A2
	for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549727; cv=pass; b=khD3BV+Zw7qxwYlD2olcZTp0eSmQCyCtJ+apMFdh3Ckok/D+47CRTFRu+qhdfQ3k21zrUrZ2rRf+4CK3vGPp9xI6MLc9kc12KRDVKkrmNh5wXy5gQ8mrYwmmJnZgncs/Fwa68gPmzpmDwjszcjkfSWcV0BM1Vp/OmC1HJDxNK/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549727; c=relaxed/simple;
	bh=UgtgITgYKhS1xqPKan1gxyBvaq09W0rkp1tX0VdRW+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlUzSx+RbMGpIlnroNJ4X1s25bJU26LOWSpovmrLy7+zlfngVjZWfEMvm3fqczn96gQ3GHlA6MG9ByyPdoW9t7hlESWw1XtVOSp4WNNMVkppLZo8R2d9wnaiFM/QJEL2ui6DvEeWJtasLJz10gu8qD+H0TEViWyc+8dNMVZlW7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ezidMC36; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ezidMC36"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1270928a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 08:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786549725; cv=none;
        d=google.com; s=arc-20260327;
        b=LIxM0Y34jfcAQU4htA51YCv6+gFMkigdGd/y1gis0og3C859Ieu7i4daLzOLg2W5FD
         nPVMOZETuM1MtSasdO/cDolb6Ekxh53aVqtyW2bwS4O/sixOV4c1qvInAFcGuMQHZ0NP
         F9j+CREzkTk8iq5B0RmRVS6Wrqi9W6rcsc4wHRnFoQsDwNj0j0OyP6WaBQaQLOEkWprM
         eucyJ77D4Q/hm2RiAeBXgAGfgveV8UEaWx2O/Ze1BRlFArPHsg3PkjnYXzLZhrJNR6Ke
         hjS2PjXS7ajJU8m4MdjqhsrAg1BGogd9aYWOvUmoFCs/WgWsMRtF2zZ97j/CepmuapdR
         01yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D3F8NRGb65pipeRw5fWHUERkQPAz8qMmvRqCUJVoevQ=;
        fh=wngi2PAPpFm98GNEkBiXnTRpOXun+RyC4c7QOsGhegk=;
        b=Y+cx6eT0FdFaKxfrw/aOs6B4jzg5MPN6T4tqnbE2e12wOqxXtgLTozBY02dzW75Odh
         6uDnh/Xufno2eWMXbVqrOcaaUS12p1GkV0G+tnQb44CHpkP0YlgnKhqDkNi+bR61Yx8/
         lg3rIiuG7vtUIlsvwaBM9ADmHX6401oriPl3wgnma0E07MiFpMjqbZIANkkatoxw22lk
         6pN4zGYpoJ3iB79CoIDGW+PZITaaAMMFww6LPgTG3OuB3zXlqUYhRWTKo6i21is1ZJN6
         Uc8E5MM7QS5x6PAa4gH5R5qFKRWFtRNzMGBENMvYdNoLWY+G+jSQx/gLt7AEhdplbADY
         kXOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786549725; x=1787154525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D3F8NRGb65pipeRw5fWHUERkQPAz8qMmvRqCUJVoevQ=;
        b=ezidMC36NdvSEo7hoEoGTrFrYyLk6Gb9Hlm9Y+4U4yHHfWFAWDsHsJZPvdSP1NnJ7q
         FPoQmBtPwF0vrhmztRPFbX7KQqVhJFSlK2n4CI7jshiG+gNytHNVJ6sZSvfZ+m6W5YPW
         6ekkNO4jIOp+5PAa1empqRueMm/OUoahJtab3lZei2OVySho9TIqtqKvRu0v6WnuXxtW
         cRoUJByQJ2gjIxEMkz2K7lHIo5WNYVawL8W4IHNC4SR15vLM14dW2E+UiYbynat+vgmT
         yLdrLjwsVkfS9mUQ+bZrp54vGtW5rsVb0El+sXS8NIpYy0s12DcYhkIK1rZmPO23FG34
         Ud/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549725; x=1787154525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3F8NRGb65pipeRw5fWHUERkQPAz8qMmvRqCUJVoevQ=;
        b=Q83CjbbJxiHs8UnPmMQ82192l3q02j1WBVIqM5XtVlHWKHvIlIHVWdLnKTy20mKxo3
         xxV3kLQH+l7W1V1vL7fnzwx+OenNZ6KXT9u51zREKgpg2ZPVtNDsmWO7AH7oo5idCuDW
         g/EvzAMO0WZaB+6Nz6mhs8kJNbNyIm7M14Bd7IpSNTVsqK/AeR/gjaE+mPcwOPXovgFC
         nCEKEvUp9egcLg3DYBACVpfqK5Su7ZmKRqyx6OovddnufSKbXTUg7AvmnVTJeMSJ4R9V
         Pqk7dk1fh9RO5frUv/s/WRC6brDl6l1oU5TApmj0Rk90bnHcKMHGlwTVAQrqdXFg2lnW
         22OA==
X-Forwarded-Encrypted: i=1; AHgh+Rocr+dCzhuc/UUTF7FOx8u9oJmhpLoUoe+VLgEQq0KV0nNkQBTq6PctDB2dWzVotM3ntHThP5zqsFJunUdqf9hJs5rsbqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz22U+i7M/kW+wU/jYm+/earOlVoRAEcn+9OR+XW3oWFcXE/t6n
	OVSaA2s2tAXbLWS7T4bdy8kIUiXOfr0PxLEPYOvyT+PJmZFhXTJYaQvmWbERal/KCCx+JDLWJ76
	ivobBY5lHSzZV3bIVCd/gNLfDfW3wkcwuEvSYXu03
X-Gm-Gg: AR+sD12uMK002tuMTrCHkRinLKm8xVgN4yhl+bWY8qp0uC7UfjLjqsnS1W1r3lyehtj
	dljHKHl4zcYBrEozU5l0R4Uwdwzd7vQ30c8vU34+0fRTbo2ChXPSnxLbNue8vrheCD4Uln0pHuI
	OozK3js4ukILzNd+qoFuXS5hyLFIoA0xafExu42bnlel2+L7/IIUGEIYGHWTIrG6keawu5Xho8q
	WQlxfCFDJ2Cbpsuar3Zuasiovw4VBqll4ntjHZJFUCI+h0RCy873QnmjR938cqIhmHsKcGIixMl
	AOp2oSVYItO8Wy/yJ38ZrDDez7MM6Z2LLl1xDtoRwyZnMacgZNAKOrk=
X-Received: by 2002:a17:90b:3b81:b0:390:b41a:b92b with SMTP id
 98e67ed59e1d1-393011b1a14mr5958793a91.4.1786549725014; Wed, 12 Aug 2026
 08:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812-task-cred-fixup-v1-1-318440888adc@google.com>
In-Reply-To: <20260812-task-cred-fixup-v1-1-318440888adc@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Aug 2026 11:48:32 -0400
X-Gm-Features: AUfX_mz5j0aFj-skG_fpX816RZDZ5GqUc1dgCp27wLePUCz5GyndP2yGyOqpg80
Message-ID: <CAHC9VhTBCwEAx8SfTYygTDu_Uoz768ZrABzb-8cgwf4e=KMGfQ@mail.gmail.com>
Subject: Re: [PATCH] cred: remove RCU initializer for init_task.cred
To: Jann Horn <jannh@google.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 10:51=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> sparse noticed that an RCU initializer was left behind for init_task.cred=
,
> which is no longer marked __rcu. Fix it up.
>
> Fixes: a4229a2a16a8 ("cred: clarify that task_struct::cred is only for th=
e current task")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608121153.nzs6HZg7-lkp@i=
ntel.com/
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> maybe squash this into the original commit, if that is a thing you do on
> the dev-staging branch?

Yep, I'll go ahead and do that.  The lsm/dev-staging branch isn't a
stable/reliable branch like some of the others, it can change
frequently; see the doc below if you are interested.

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#dev-stagi=
ng-branch

--=20
paul-moore.com
