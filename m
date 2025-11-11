Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D793559D9
	for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862048; cv=none; b=G4kO6XloGtMocNEWdCXAncsQcxDKIJwux8nPTRjElqdB32/6voZr0weOxOoNpEMOw3qIs0Pu7Zk8yIqYCLLDL4KzYi0DX3hialnKB7d2FpVSOFOlvxPVaeIMYF3vFUwd7GnnZgyaO4YJMZza2MfhjzkslY7SQz/E1hpuCBC/zqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862048; c=relaxed/simple;
	bh=ToY4TL4/qwontWIUOqwnL6q60lEkQZbsmA8tTEk2d8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qt8uHD8KRz+iJhRHUILEKKVoj8Sjt+OheKolnD27+vi3yGT9pp8FC2c9VDxDOW11gxXIThyrqUSntGr8wJJkg4iXnKQodqzMHCPdSk8r9ZZdnbrpvZnBaULxgYTJmsqq1d6IKww2ZqoWbQTsxigp1sw45v4E1GoDwEnn3xKFBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV84svQT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV84svQT"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so2941431a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862046; x=1763466846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToY4TL4/qwontWIUOqwnL6q60lEkQZbsmA8tTEk2d8I=;
        b=bV84svQTQU/24WPRQv3bWGaHxAB/W8QYfqeEp+4TZv0Iq3Lyuf0vJn/4HfQcX0w6q3
         o47YmmdkiL3NVAufzQdXx4NWPkWJypzmDNyTZM0yoPgzoAB51amiCD6toscbME9d3wtX
         prqktJBoNqZ/fxYm3FeHhoxJSMkR/d9p4W0qHDMCL/s6hY9taWfrIRysVP/MVyOQ0U7X
         tBid9NpCbc/ELbjI0jQaQ91XqdoPmhqDyv7qhpFG7zgKUiRXjEXkndgI7rCcZ+kUTvao
         4adGm/mu8po/4Ty6FcZTIRhCEx/Vbr1C/glyNDShUFM1b+tbPaoYdeDgeV8X5r3ihYkE
         CcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862046; x=1763466846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ToY4TL4/qwontWIUOqwnL6q60lEkQZbsmA8tTEk2d8I=;
        b=OvRke/m61h4MURGEdC0ZQnhosuDKq5HIUeZeoFxxuUP9buBUajQiiR7KVohtEioc0N
         aLWhLkGM5cwS7GLsq0z8ARCmdsFmfFHSo4DA2da9hI3pTJeWPamCFK8/GVzDjKsgaMD8
         eelZRIS+jVbp/lFjhK0qWtsVFnShJNpUhix5Ej1hu0uaHHPIDDcK+d1Dvmq/yQM2yKjD
         4o3SqA9hPxXTfrMpqtHczUKGgp4zvValbdNYlLzPFVe2Kpwws81CEkglqUh6cVJysHUf
         XMVV3dkNyKsRtKfkI48TVMNT2bJX43KJEM1mtqPcc8hoeOm2kbDmxTsFjC9NRwB7SV01
         ArEw==
X-Forwarded-Encrypted: i=1; AJvYcCWgUKqsUhw6pyhktLzkR+smM9WhslMD5LDSAkqcR51YiJSriXmRIwJ43oYSQcEPepLzqgiJxP8nvp+N6tn9mKsz86qjxXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuDA7PHe+8u2ta9ENLoWrk7cbk2WWKoFf9N+5lKEHGOHBbuzaK
	qV2bWRIihJixRxALcP6rkhXfHyR57y82KpShZ6WvdsSf2qlckpYeBWpGJPi4JcYD4aj8Xihipah
	oAaFKdgCHPAld6b0lD8/UGW3VOfEFe5o=
X-Gm-Gg: ASbGncsgFIfmZk6Y42LuygRZ040h39vpQUEhnY7DZtdw8Rua4as8D2UCuRf16TWgEhj
	0v5vorwiK3Cs6f4+CqFrVuIMBS6eoEa1rD8Q95b13Ngsrwne45RD9KQlq543zIgbdSgj6QqKnQH
	doJPCBD5IfhGNYQLYK4kgCrELFiW7SbC7BBOYaSa2U2tnd8COmxrEFMKuIoFiFFdcFPjWUYoE8J
	loM+cn1OQ+CQXMXxy3vmWGtV/cubV1J29SSQAqPFCWtdKzAfMyYkC1NnkGk8Gaxr1eYISuaWJ0f
	cRCVVBwqZKgisvMALLLafwiHHA==
X-Google-Smtp-Source: AGHT+IFTSzzFA3Sig6SUf+l63ywNKbdgVu6wEW6YjQvjoB9NpZdnt04WO700x9EFuZ49zyQsyzAGcOCZY6qw9HwoW9A=
X-Received: by 2002:a17:907:6e8f:b0:b6f:9da9:4b46 with SMTP id
 a640c23a62f3a-b72e056cc6dmr1243184266b.43.1762862045550; Tue, 11 Nov 2025
 03:54:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105212025.807549-1-mjguzik@gmail.com> <20251111-fluss-vokabel-7be060af7f11@brauner>
In-Reply-To: <20251111-fluss-vokabel-7be060af7f11@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Nov 2025 12:53:53 +0100
X-Gm-Features: AWmQ_bmk0-blwk1PQ_lsyim7xX9U0NCT0sSRyAgQiFcSJIzJoe4wx-mIvQrdsdc
Message-ID: <CAGudoHF_9_7cEgwtX=huvSf1q-FF0gSwTn2imXHmszYoa2xPZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: add iput_not_last()
To: Christian Brauner <brauner@kernel.org>
Cc: mic@digikod.net, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, eadavis@qq.com, 
	gnoack@google.com, jack@suse.cz, jannh@google.com, max.kellermann@ionos.com, 
	m@maowtm.org, syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:46=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, 05 Nov 2025 22:20:24 +0100, Mateusz Guzik wrote:
> >
>
>
> Applied to the vfs-6.19.inode branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.inode branch should appear in linux-next soon.
>

That might_sleep in iput is already in master slated for 6.18, so this
should land in vfs.fixes instead.
