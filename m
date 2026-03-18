Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F73E9F61
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859852; cv=pass; b=EMvGr9u6xX0ytre4rCczjZgvVmoSC75dz+ZhIk0wvVNptmSBvBBnMT3Gzh6jhoErhqD1uGA72COdvzOAnSMxCow+eDSuFTp7JIhVXGhWxE/S3YZH9uBvfx7yjMWfRNseMbyJiJwYG/0hh/QAOzzpiR65kGAVwT3sVHodPCCXstg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859852; c=relaxed/simple;
	bh=lTLFFdb/lCfSHzVXX8tqh4A6xeww0Hh5IUhCB1ABbHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxfC8CUQs3gC98uviNofANsRCKfQaHwxS/wV74tgsxR1lF+BZFcLv1q8sVgLWhihiX5AnjoOstZ645hb5o07/9ocBYVJlY+iuNANv9nYGB1njMDCfnBED87plwiMipwdKVDgD2wgIvPIMzoa7Aw8E7fVmV4IdAvXezEhskLM/5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WVt4XFH6; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WVt4XFH6"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-829b2018c94so163002b3a.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 11:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773859850; cv=none;
        d=google.com; s=arc-20240605;
        b=F9UPjBH57/CN5JhgFFwj0Nnk76Ds2YPR1gP6S6BR8hmuhXv9Nr2Ue26DAyadnn7+B9
         Muk7IzfGubehpanCFbsoMn+gCNACo5vv/6h97d/nHORMniScde++UdNdCT+FZyZo7piW
         ekZCgnPufbGnrXxIIVZ400g/23HSJ0663hPH0gApCX1wAGFxEr0HZm7aT8iczKnmRi2s
         OxPkcwohoGHhn5R2OeKzYrSLfti5YXiuNS2e/eRuRIiTbDlD281WRg6LTN9Ew4x5USki
         Xc/lIM7d0c1/FJF5QsiquGgUR3Y6hBzS4G/1z2EqWOmzgie9R+Cl4asXAaLmKd+OAl9L
         qg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=auJxYh/r/neWGhZWh/YZ+JKuUpA3BpjR+/HoPWRbPhE=;
        fh=MNSGvGrcXXshqBeAo68drcBMj192/maTgzlntJGl4UA=;
        b=kqzArUWl1glXBveSjmOE96RV7E1GuOqJ18I0qI2OuIN+iHLCNiSTB5PE6LvfK9C43G
         PO3WxCTqWhKBJxio2nb9pS2M0w+v6Bll89UxvGJbyEJyaDzHH6w2co06duUoOy3QaT0d
         l9VnTrj672NUEGutgkouSYLxh7Wzk0XrhcLxaQTMH3yvRYTtd8V12nXMW3XBJnSMk5eo
         VrNSWkEsVWsLbdagqdnzP7Qb9sdeIN37n/HiSDPibpaYU99LDwdMyaWfBPgKFwnNezrB
         Zt8XCvKIxLsdMIrs1ac6TAXWi9Dk+Kt9KHHlZZjD8BF31VySXDmEhcGP1cr14m6AfgDI
         /sbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773859850; x=1774464650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auJxYh/r/neWGhZWh/YZ+JKuUpA3BpjR+/HoPWRbPhE=;
        b=WVt4XFH6ir4wKCdzudQSobKWMTXjO0d3KkoH3U/cu2LUMZFID4gupqybXLIyvaud3l
         xAMigaD44SB2y4TGYV16rSO2xjKPlSBb2XTRnJNA/EqDX5EG3XsQ6giHnWMV9r/IJsNi
         3v6RulS1ExxkRIKqhsZitaNpXMiprL869uT0jW+blYocTuDmUo/Z4E0M8a9x+kMga3AG
         qm8iAMv9M3W8KDeyu1XymMQhaljs4n7bhYriFmDCXzXuvT/WUvY95b2xXEootIlfYMmO
         2cBo/FOlgZ48a648QOXR63DUI5JMmXM91SlyXxkc0b+J4mrGtKBcs/1Xw29IJGz47xNW
         uY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773859850; x=1774464650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=auJxYh/r/neWGhZWh/YZ+JKuUpA3BpjR+/HoPWRbPhE=;
        b=S13xTHPzdoFXcpXEeLCc2FFr9ftYHpkZ135kj1zhy6xyvijEPWVbcEKgs/qRKN+tG7
         M0JoUanBlMq2eSgh3ulrkwLfd0iQeEkCj7R54Di0BCxsjsnzUmg+MWxqQRh9V2GPBpDN
         gQ5jIxKuL7a9vWaO79nAv+XVq2jLSrF2rgjIwrGf+hgs6Wp2GJKmj6lA0UbpY6+BLaQQ
         lEuWcBqNT+fn7d9o/fVtHefh+owBqBl/mMEIWXtbblgnxO4WYQKHKMb1oBgi61F/Epm2
         wHlLjBS/PUmFFAlUXQ/O+UBlWudo9PiPNUhMXf4KUH7iL9lkCNNPFpfX09SmVHHXLwBV
         wlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVZxQxFQmVK5Wq9CxrN3kNMpwf3f+2yEdhUn9R5qX4jF3xbVcOU1LpYZctHY2IqRjhofsTrgQ8Be4QC2T/yzSFT43Y6IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtLA840i+FjLaSC6O4Ic3hz37mQR1dHv3RYzt53UlzAugVZ6b
	EjB8lK0izOxXxqOuFn/m1TumOH/i/6BfyPoNYRWFfLgJ3o5WCx16X+ZjyYBysm7rfZlzkQUHor2
	cf9ETg9Ws6razvaNJwHhFN7bU27WRr9Df7xvT7qPh
X-Gm-Gg: ATEYQzyFExMlSpmKBSQQjm+cc6SRngfizgqjo3yyk7Ax6We0lbcxFGHf/3xRhBU2C6o
	1SPueArrTSRuStq7NYNK2+hJkKArmAOuzdstkUmGasX3KoqbaH3XoeRL2fxcWRc2CEQfRvbTztl
	SueDAZQbDLcJj3dgUL8OulFYyFBdjn6InvO/c46dJkVGlNbbxaJIXKK8ohImVjou8vW2FEogMzy
	Rc9Fpc5M6+SZpbn1T2PHm6EYXOEotFCj+V7qKZD5yVlA5O/02dgMG/wNb7fZtxhI/F2FUTxNPy8
	IhDj78ouNWum/DkbwQ==
X-Received: by 2002:a05:6a00:1708:b0:829:81ef:df10 with SMTP id
 d2e1a72fcca58-82a6ac399a1mr3793802b3a.13.1773859850097; Wed, 18 Mar 2026
 11:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318104322.1643085-1-arnd@kernel.org> <CAHC9VhQoawCxVSFGY1whF_pwfH0FHrT7QFC6cgWeFV2XApC6hg@mail.gmail.com>
 <fe689975-a8f1-4370-b99a-b3456182ab37@app.fastmail.com>
In-Reply-To: <fe689975-a8f1-4370-b99a-b3456182ab37@app.fastmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 14:50:38 -0400
X-Gm-Features: AaiRm50Ib8_5zOFEmg-qAmvPSBS-OVxO7_Q98E-jYfEntfhpE0RJ79wm4Sw1QiY
Message-ID: <CAHC9VhRP6hBL1G_BAPfjUMpHR61R9vZQaDOgnths4TrOXwtTVg@mail.gmail.com>
Subject: Re: [PATCH] lsm: export security_mmap_backing_file
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Amir Goldstein <amir73il@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johhansen@canonical.com>, 
	Christian Brauner <brauner@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 1:17=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Wed, Mar 18, 2026, at 17:29, Paul Moore wrote:
> > On Wed, Mar 18, 2026 at 6:43=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>
> > Thanks Arnd.  It looks like I'm going to need to respin this patchset
> > due to other changes, do you mind if I fold this patch into the
> > associated LSM patch when I do that, or would you prefer this as a
> > standalone fix?
>
> Please fold it into your patch for the next version.

Done with a thank you note added to the bottom of the patch description.

--=20
paul-moore.com
