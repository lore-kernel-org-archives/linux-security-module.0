Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B3154C0E
	for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263916; cv=none; b=YWEsN9N2rR+XtOCDMKlQ27VVBTWYsRRFr2dzg6OjdlReDlJAuK+wX8pERJAXFqooeMY4tUKCBLe4BVzapGgqTVu66EcH2XYv6vCUZSIoaSCjKe902TW5Mdte+V4mrK5i75rUjr3qjCA7XGPMaxVBpx7xLhQ4U4uutC9utKrvmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263916; c=relaxed/simple;
	bh=FRuh+KBT0a7k37NAtcwsuij34NzWTTyM/ab3DyrzLEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4NiyvQk+z5Njb658ZPrqJl9ge8bf780ExOdyGmZxgySlfFQxkxh+bf5SQWbyZk6bKBdvh8kDOWe6GeCwilZmbQ0i27zhcoNzHuXfcXYhllaIamwHfyo4zONdUdbqbsrPVphgiiddZtMsliUfDfaa2eAMcQJ1aX7zJl/RQx94JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I12/DHD4; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I12/DHD4"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso1407840276.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Sep 2024 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726263913; x=1726868713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lwn37t/iSKoOZ7UvHqU4qQdhusIvGBPeQaXOibPFjp8=;
        b=I12/DHD4bbOdwoFHzXxjuJmT6OqVkMcxItHTOZi0kXc9nf9xFq03PglVxV9EUeCgBD
         n+sQRj+Z224C8/rtuBCqrE2HyjBtQ2QWZVevjOZd2Si4IhUahQ3C7nXrKTGtuMsYPX2I
         eIhCvWPV+nt7yEKHE9YlM5/9I6fWx8ne2kfDYpf49/LfCgPSuKNGEurcN9MhGdKV5LTZ
         LRAfsGuPWKgcFdrUk/6+M7SPcUt/PzKG+CyslKYjL7TITE994UCRBe34Kd77B7oVGl3Z
         j1AT1uqjQLVQY8kFYauvF6xYnlGBRXCANrBTdmKN6SfMy3yj6AbspkbLT4ACarPeA/0g
         a0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726263913; x=1726868713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lwn37t/iSKoOZ7UvHqU4qQdhusIvGBPeQaXOibPFjp8=;
        b=V+ReIunToYQ8whjCAPKRgC25t34HiYEXOv8X3iNTDMWu4bT0nulcblllrwf8qcgXn8
         BQg5rpkadfIPdqyHMsg6qko5VxLXpGXDP6vnLYNfOV0g+cboApkZQw1NS2xEjIEH9o6F
         URQpfluOmDVwkzj0PETc23ZVkBH5GeSsvM0rcaOF3Erdlp6Bmg7+F5+0Jyk2NN4k7vFY
         Oai2tcE7RxlnTkWZu0oVL0thGihNobgJLnYOqfQm0rlbirzqF1wQuAa6zG56FvSCAlEN
         gO6NHuTf7BiHJJ1N2GIEVmZPB2R94BTZb2RfNgoHaMLyyto0M8pBZrS9S3YK06kEc4sy
         Milg==
X-Forwarded-Encrypted: i=1; AJvYcCXkV4Y56jsdMoXock8JLta+CPSnErlG9uIuLLE2R85v0x1aGZLHmDoDwb4qrx+QABOvKcycEF1CZNNiBUWSe1X+VdhmZcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLJVo8XgBjG96PJoctBjoCiKFmdfSl/JfHTYIqWV08em4+uG6
	NEBAcIbsfL+0E/sWwBSg/UufPc7Hd6wLvKIKTj99Nld0ILn1CJw1zaWULHZPNL68FCnGzsi9sWW
	E4OJWW8RdX65GOeTtJBjXOsHZb55MFeuHSOY6
X-Google-Smtp-Source: AGHT+IHVR8chyAryrgWoD0CfuiVCPSTNyXA8dqCpTcxPwQRyhtBbIrntDXbyeDkcU1pJ/lYcycmDXrk0C8l4LPdW6YQ=
X-Received: by 2002:a05:6902:2186:b0:e1d:2261:cb25 with SMTP id
 3f1490d57ef6-e1db00c664amr3581421276.18.1726263913366; Fri, 13 Sep 2024
 14:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910184125.224651-1-casey@schaufler-ca.com>
 <20240910184125.224651-2-casey@schaufler-ca.com> <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
In-Reply-To: <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Sep 2024 17:45:02 -0400
Message-ID: <CAHC9VhQfLRfKTjksZ=KxuNPHXXUAV_0Q0ejKEDmFXc82wOZu2g@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] LSM: Add the lsm_prop data structure.
To: Konstantin Andreev <andreev@swemel.ru>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:49=E2=80=AFPM Konstantin Andreev <andreev@swemel.=
ru> wrote:
> Casey Schaufler, 10 Sep 2024:
> > ...
> > The lsm_prop structure definition is intended to keep the LSM
> > specific information private to the individual security modules.
> > ...
> > index 1390f1efb4f0..1027c802cc8c 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -140,6 +144,22 @@ enum lockdown_reason {
> > +
> > +/*
> > + * Data exported by the security modules
> > + */
> > +struct lsm_prop {
> > +     struct lsm_prop_selinux selinux;
> > +     struct lsm_prop_smack smack;
> > +     struct lsm_prop_apparmor apparmor;
> > +     struct lsm_prop_bpf bpf;
> > +     struct lsm_prop_scaffold scaffold;
> > +};
>
> This design prevents compiling and loading out-of-tree 3rd party LSM, am =
I right?
>
> Out-of-tree LSM's were discussed recently at
>
> https://lore.kernel.org/linux-security-module/efb8f264-f80e-43b2-8ea3-fcc=
9789520ec@I-love.SAKURA.ne.jp/T/
> https://lore.kernel.org/linux-security-module/960e740f-e5d9-409b-bb2a-8bd=
ceffaae95@I-love.SAKURA.ne.jp/T/
>
> but it looks like a final decision to ban them is not taken yet.

For those who haven't read my latest comment in the v6.12 merge window
pull request, I'll copy-n-paste it here:

"My focus is on the upstream Linux kernel and ensuring that the
upstream, in-tree LSMs have the best framework possible to ensure
their proper operation and ease of development/maintenance.  While I
have no intention to negatively impact out-of-tree LSMs, I will not
harm the upstream code base solely to support out-of-tree LSMs.
Further, if improvements to the upstream LSM framework are determined
to harm out-of-tree LSMs, that shall be no reason to reject the
upstream improvements.  I believe this policy is not only consistent
with that of previous LSM maintainers, but of the general Linux kernel
as well."

--=20
paul-moore.com
