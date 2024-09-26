Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528119BBC
	for <linux-security-module@vger.kernel.org>; Thu, 26 Sep 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356577; cv=none; b=ZrD1xOKvaLpPkwr0BDCynXJ906D/0Vcxv3yIdnzar/Yh6+XLhcL/Jy5mmC/k+5lJSBRbIQWchTPqTGOOdH7PJOcedZE5utHArITLTkuOR0rC3hzlhGkKfbh468zuo5p46924mxtmCx3q/nzWsuIl9MHZoopm59yAVW+OTCXWbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356577; c=relaxed/simple;
	bh=N8iSSR4SiJU4tpODu89h62X9P5kjyf3FXspTHzsgfkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbsETZsl5lEVCHezmlnhSRpCV+VPW36CmgJ6JGcS3ZYKo4QqHLMI9uH0otp3+Esl+9QlaPRra4MPjIgV0ei133gj0vr0N81SsMUvFo0CGc963rl5Y/qGKRfOlMm66ArSbJ1yxeYIqjZ9JER3hVq94AGK+6kZFZvqu4CMOrUKLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E74UfVnm; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E74UfVnm"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1d0e1bffc8so953167276.1
        for <linux-security-module@vger.kernel.org>; Thu, 26 Sep 2024 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727356575; x=1727961375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsxBurk0YfSGfR08s3lb1wtlbFNTpWqSLk2gh5knJmM=;
        b=E74UfVnmnmbf0oQmUMi0/VCyqmLlqySk6JBvno8Ag/nEieGPvbT/JHIcXFbcvj/l+T
         fyw3Xm1+B2+u7eIPtKMOgybaa+6f0qU7QKxI3qgvu4E7gnQ1Lz9GgppeGQIOqmyda4bb
         Uf2sJ/LGuxx8URyYsnsoUQOYtISFb62zVwVhVg7txkqGZr+vkU+CVm6DdH+1jKDeN6gw
         mVpPtpMC3JGdP5+BIyQ2N1jzup8tPaEmxevuwaBu4t83IroKRGTlHG76pUqQQPFsL7Ob
         NnjbyRoi5oXeqWPclDV5Vb+jknyRcvhDw5VEvKs0p9jK66mIrQbbpKjElKTWLLOvEzHE
         IvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727356575; x=1727961375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsxBurk0YfSGfR08s3lb1wtlbFNTpWqSLk2gh5knJmM=;
        b=Voy1+wM5+89RRdJOu1c2Aw75ZUoYbu9mTAye+JYLCNl2SNFVTQVdwFsZsZRCOItgTU
         zw0Twd8XqMvoO5uFrk4P1hlWdh0oa4k0a7GvzResFJ59OQ08pUoVxKhRwH7OBZQEDnKX
         QWysgPW+vMbzkk7Eiipmr2moXdtopG8/57l9MoKZNwLDB6E3GOCdK/YHgobGlkaWRzlt
         fhSmKuCBJzA7kQtsCOHY1+sGYlu4FEFdfjO+3NJL4tbE1SjJn7uuC1AV+UKT+EKN0Jxp
         LFJzMxKSVNsOdu/HaJreczel7MqMPxpVwUjW9jICaDppdVDoidfdCkKDeZOXV8bxRTZ2
         bf+A==
X-Forwarded-Encrypted: i=1; AJvYcCXUVKdgLT/jD8bAcsMdTEI4bZ+ep0Gf14Hcl+Hs5SPjbyEW+PlGM4R+WA6gnTuLyVIXOib2xtbNav39d6RlL9Gfn9l1vto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sdbMBIBRrx4Jzn7sFtri2fjt1kNmpPNJNifqYBQd6c7SQQUZ
	Eia/wtS8RoUFF2gHjJr9CE34rdysRW4t+UTfmwEm44BobU63wf7okASGrGJHQao8gS0i7SZIoFN
	lwHBvAlh/FhL8s1UDjDqtqMMBE6j0rAH37k78I26OORQwxfk=
X-Google-Smtp-Source: AGHT+IEJ+yp/ZgU9R76fR3VGGZAJSA7u4vUiibgn7rfpYWINW2DjxdBBprkEseEzQdujq2++GscJ6J+dOVQ12kdwIkk=
X-Received: by 2002:a05:690c:2e8e:b0:6db:e4bd:54ac with SMTP id
 00721157ae682-6e21da8888dmr40976237b3.39.1727356575003; Thu, 26 Sep 2024
 06:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925192018.15290-2-paul@paul-moore.com> <dd386a1f-9245-45ae-b0fe-d07d1dec5100@schaufler-ca.com>
 <20240926131157.GA683524@mail.hallyn.com>
In-Reply-To: <20240926131157.GA683524@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Sep 2024 09:16:04 -0400
Message-ID: <CAHC9VhSyYkq=AxiVkwkuk1jsTTCqt9xypdto5yaX3jdLXy+Xxg@mail.gmail.com>
Subject: Re: [RFC PATCH] capabilities: remove cap_mmap_file()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 9:11=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Wed, Sep 25, 2024 at 12:45:20PM -0700, Casey Schaufler wrote:
> > On 9/25/2024 12:20 PM, Paul Moore wrote:
> > > The cap_mmap_file() LSM callback returns the default value for the
> > > security_mmap_file() LSM hook and can be safely removed.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Thanks Serge.  Any interest in pulling this via the capabilities tree
or would you prefer I take this via the LSM tree?

--=20
paul-moore.com
