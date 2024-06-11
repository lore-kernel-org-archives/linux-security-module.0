Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C17BB17
	for <linux-security-module@vger.kernel.org>; Tue, 11 Jun 2024 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136388; cv=none; b=QDXAFxAypr+filOT7jbkndPereQNL5JTdSMwKYE/fX3kkl7FNaigoAjYbPGmjTJKt7LS0xEPSXXmTBvDoKWm3v/UO5gaoYpQdQuxjhprmjb7xPkh+8puO1HMmk+ywKYy/qGztNNuaNDrTR1CvmNz0pwR7ucVMsOlXrH6Q1sEcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136388; c=relaxed/simple;
	bh=6DuGM5fm9sMdiKKC/WzqFLjAfDr5pFOPi+UtnZ33exA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBL1v1X5y4GuYJF1b0E8IMnYNwt7tJu4nVGIXM5F6AYoR8pBYk2A6FQrfpbHnFi7Yqpz102XTrzJnIAl2CkoAPNTuURT0Z5/G+qS3c0d9jwgNr7MPRrt3praK6e4ud1Q2QPRmucG+YK+NEGo7A+eQeMgv+jQmVKKHBryeyWmjts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IqOzeNFY; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IqOzeNFY"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-254871388d3so2161554fac.1
        for <linux-security-module@vger.kernel.org>; Tue, 11 Jun 2024 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718136385; x=1718741185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CExcQ4PTPEISDHLreU0FYNDPVjS7h+Xb3qqAXzSA+o=;
        b=IqOzeNFY03R0cXDbAnICbDCC0jgE5zZQOV+vZd9DZ1uEfJ7oNOXIQXffXtvMxCgh0F
         KsF5UZYk8mlRbAZr9a1lNjWRClDVRDI6i+gTAW1NMtu09SqQ+TTt8t/PtxfM9CwN5Ede
         ylPGnC07y5SW+6HNQQg5QRrnegfozy8Pn6y3cCjzflhIeU1nu7AP7vFiav+XHrsupHz/
         INPGlfXH2B7FRx1jlIuG8fYHD8koZsLs0lhNd1GmWOuzg7BvzBJ1bOfDKp3vCyIIZyPN
         W9jxlLzPnfAkfRDCalHFJGJZPW4r8T5aL6uNr56V3DHmYTGzERKhv8LGl/fI5cUs68MY
         8keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136385; x=1718741185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CExcQ4PTPEISDHLreU0FYNDPVjS7h+Xb3qqAXzSA+o=;
        b=dtMAcaUNbs7bVV8/XkngxDHdpxNnZ28LbdUzc3m2E55ecaXS1aNb/91idPqna5XEOu
         zgoGebJWgiIbx7+65bZWJ5rOfYbRXd/MWNiq7cYUqZVpAuqKLVJDvsXi6tCmXaPJNk1k
         3qc+0o6zGCq0+ciQRifXMWFe0/imjvcCTrru16+rWGDb2EUUpJXEglmz7+t2/XEK+CdS
         WLumxc1IXaWaRSKKjQsQVvlltab16cVcxIXse6xrbAP/vF41VNl2B/lNNsjGe2bXCzeB
         UojrtCuuiIlfMf5Rs1Dz2c8FtuCCD2g5/Zt4bh8mXAU/vs+Hfja4AIRug8BH5QZqOXzx
         fkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNrRnBSqFU6JUB8tjjCvuaX+PMJrg2z5SuAkpJp9sMGLm53qtSNfzf/mI31S5gJB3ahjDBb0chCEXqZ11On/DDM5VDazcnkh+/alOB/YypDMSXJu1e
X-Gm-Message-State: AOJu0YzoSbWSjSq55deVbob4KBz+S5K0B2GuhrsZzmYH4kF/G7r/Lmo5
	4R2FKsFBl+I7NRpKyWYAU/SLfohmHlm0kkF3OHuDAwBbvkW52p+u3ARys9DmpPidUmFIcH1TldL
	VT9otZ1RFk2Cz4/NXbWaczTsWJpgy2sv+dkD1
X-Google-Smtp-Source: AGHT+IHHH4VJZvqHTtWeog2nzZW8lbhZbgh0NRNurmKB3eipae72c98a4akNavV6vsz7kIP9Mcb0pMY7Gk+umjSzE/0=
X-Received: by 2002:a05:6870:9613:b0:254:a217:f8b5 with SMTP id
 586e51a60fabf-254a217f9f8mr9516338fac.39.1718136385566; Tue, 11 Jun 2024
 13:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
 <20240411122752.2873562-2-xukuohai@huaweicloud.com> <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
 <b4484882-0de5-4515-8c40-41891ac4b21e@huaweicloud.com> <CAADnVQJfU-qMYHGSggfPwmpSy+QrCvQHPrxmei=UU6zzR2R+Sw@mail.gmail.com>
 <571e5244-367e-45a0-8147-1acbd5a1de6f@schaufler-ca.com> <CAHC9VhQ_sTmoXwQ_AVfjTYQe4KR-uTnksPVfsei5JZ+VDJBQkA@mail.gmail.com>
 <61e96101-caf7-456d-a125-13dfe33ca080@huaweicloud.com>
In-Reply-To: <61e96101-caf7-456d-a125-13dfe33ca080@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 11 Jun 2024 16:06:14 -0400
Message-ID: <CAHC9VhS=4fpTs4VusORHWxjL6bDB2KExbpRSRYTtvMkc4OSObQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] bpf, lsm: Annotate lsm hook return
 value range
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, 
	John Johansen <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:25=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> Alright, I'll give it a try. Perhaps in the end, there will be a few
> hooks that cannot be converted. If that's the case, it seems we can
> just provide exceptions for the return value explanations for these
> not unconverted hooks, maybe on the BPF side only, thus avoiding the
> need to annotate return values for all LSM hooks.

Thanks.  Yes, while I don't think we will be able to normalize all of
the hooks to 0/-ERRNO, my guess is that we can reduce the exceptions
to a manageable count.

--=20
paul-moore.com
