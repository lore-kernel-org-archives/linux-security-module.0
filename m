Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2011E5022
	for <linux-security-module@vger.kernel.org>; Tue,  5 Nov 2024 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845606; cv=none; b=eWJd54fmmzPxEXuLvgFuv4AqU9IpAYDez/O9e+X76wO5geY0k5+cld/ACtWN3KO1z7ClfOal6nJ5KCwUY8kqhsbARnlcv75Av0/NWjMd5TA+khc3flJ3jH7ratMBgNfGPoG66EbdRsSU31D8XSwdu/vw5D4PhMCplveDU0hO4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845606; c=relaxed/simple;
	bh=UmfGUFjoCUj6EGPg6mK8BH2Sml3/fA4yAFPTVcosKLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvSQe7kO/72io6GnEoZCylHOi7S2RQeC6UzdUV6Kg4kAPCfL76wq7iBnNtPTBuyo9aCtrt5pcQA4n38iHpszw6FOZxfg9NMWG1CcCQbRGxdjhPeYp+Ktq8/fY9l96DGM/BmzDnLVb1pbnoyj+p0avtJfR6tjqJaIQJvi0s1Kj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eiLknadI; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eiLknadI"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e29218d34f8so235032276.1
        for <linux-security-module@vger.kernel.org>; Tue, 05 Nov 2024 14:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730845604; x=1731450404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3cKkwcCJqU/mGS7Kxwzw5JxByTWH5skpXt5BnFKrQU=;
        b=eiLknadIH5XGa5yi5+w4K7pXdJ0VH1ANob40UjxLMdwIdBfU5S6KSMn5soJyBSXru8
         mdiLB9p2rVNxyZXFJlp/4eG0fLsCDOGnU2DYE5JJNeG2AjxaY6tiNbmnGb74Ph3/+Rh5
         pvh1Na1dse+tj2TZ7MmxjxpBXlMOW+RHZFVjhrgHVfMRbdlhke9JrOIgoEm6bdsd7zkV
         znFzwa8BtM4QBP/zpD0ZP/lcDpH+Y4LOt/vtHriqzaeuB33oERg5dcZMS7hYO31VAYni
         JUXfropuoQ/OrXon1G7W9pMYiO6lXppRCuWVJBpkA/CWcvrSFugDm4oFqj/celjz6DKq
         GY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730845604; x=1731450404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3cKkwcCJqU/mGS7Kxwzw5JxByTWH5skpXt5BnFKrQU=;
        b=dag/lGHelHjV2Wl5WJV2Tu5nD46yvIni26jMYaHa4zKDsU1nho1oj5QIH/0ah0YJDN
         TURLj5/50afI18z7bpQqaeqTP4Xr+INotKQ6z/lW8r/6ahrW/cFpjGSAAegGcqg7W67r
         t+Iaf90PjT1wadWrAmQOSIp1uebEaXxI99ZPM3/XBc1J/6qkG5AjeIozP/V1vIKEK1HE
         xsPX2fYSkezh28yixtZ3zaE+JxNaYjvgyyC+pKcpfFRjdIq7zgvH5k3iOGlsi+MHZs1n
         ZkKG7X8WlwWXlmu97Xu8B7wPmMsV8EKh67sRWYBzM4tk0aoONAMeZVZJ0TU2bRtqKE6/
         5LNA==
X-Forwarded-Encrypted: i=1; AJvYcCUXWwSd9ZLFbU2dHgtnayvPimQKzUOfkQnFIB+pIGKGUmtqSRLXOl+SSNfJg8ylZDt14Lzf9OffnBk33ha95SjQF4OXkZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtI8VJuB4mFAlk+AOnOEbjvZCQRMAcrb0L6YBBjId/gAT+kVih
	5MMznkYSKjpMUIR5bu2rbvUMTmPgO2uT4Dil6Or7psUKZSmt4doIAhFhO9F9qcJyDC7elqfcObV
	XqxDtvYjX4d8KX7EGbFSIMqG8xFa6oKuTfECM
X-Google-Smtp-Source: AGHT+IG3o1wie5HBchExa2v9rxl7jAnnWX3ZJy6Lat50mTFdhUVnqcoKN2VlQFEwKL5HhjCg1dTMesZF6qnwO4sIICs=
X-Received: by 2002:a25:b9cf:0:b0:e29:2988:ecf0 with SMTP id
 3f1490d57ef6-e335abc7e94mr250839276.10.1730845604540; Tue, 05 Nov 2024
 14:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <55401269-240e-43ca-83fa-97b089de5f19.ref@schaufler-ca.com> <55401269-240e-43ca-83fa-97b089de5f19@schaufler-ca.com>
In-Reply-To: <55401269-240e-43ca-83fa-97b089de5f19@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Nov 2024 17:26:33 -0500
Message-ID: <CAHC9VhT5Un7svpM5ky4RTMr-GUhqqV3kqtom-xM3k8+c127msg@mail.gmail.com>
Subject: Re: [Patch lsm/dev-staging] selinux: Fix pointer use in selinux_dentry_init_security
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 3:37=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> The cast used while calling security_sid_to_context() is just wrong.
> Use the address of the pointer instead.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/selinux/hooks.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged into lsm/dev-staging.

--=20
paul-moore.com
