Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B504A3F25
	for <linux-security-module@vger.kernel.org>; Tue,  8 Sep 2026 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788906166; cv=pass; b=mSxv+nYP/M7L6Gzppvvb8+6jfjllY7WZ9gUUnA+V4C47b9U+Q/C79Dg3AfdcM0N1BUPfXdBAEkdAhOpkcqFoOZ1Cqw8LKNh+nU46gRUd4Lmkna3efgLtjVxc1azI4/bst7rs+vXo/V0t5RJZbFP8POXUPdCQPYlBZ9FyWcIxJUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788906166; c=relaxed/simple;
	bh=PUq1upF8sqxzV9pdAF0Io0GcpgTluz2WtknavoZ1se0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfpjE/0rX5qmSUDODSu4MpLiYvH8SPFBNvpsfPEdo0741yNc9EQ+6Kwphn13rWsOLJWLheVosyO6tyYabGMHq1GOxGg9kaXaFMge4kurF1oK6TPbbK5EkzjTTpp1lwF8hCIIYdcg1gfBR0P+1HZKpgjXo1W2uGA+9FQxZUaULGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ADQf+IEV; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ADQf+IEV"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d7so376104b3a.0
        for <linux-security-module@vger.kernel.org>; Tue, 08 Sep 2026 15:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788906164; cv=none;
        d=google.com; s=arc-20260327;
        b=koTtNVLU4AiZ8UWUUcQ3fSIZtr18aG/kdRqv+hH1SDI7Wqzcp0/X+yPebLkknGpf5/
         D1CLHO4sTLLHYNTjutHqY967FOY8Fo+4I+UNXe/UrnEjdEbsYs9+9BOEW2umc8DvAMvV
         IkWxXwgfcTyDzap6xr5ogC+zXuu4wkfEu3DIZK50H/cdL1Vbvoe9m71Lt8B8mnuI7EB9
         SgZl89GLg5leF1qbTgTAV3Fy3k4h/+TGGLCHeG5C2ST4hroNQxTJJY/zcmp2bPe6JKB3
         D21O0x3VP5Qa6Sn2ZWEhOp+AGivfgQWjEGJ/Z/iKF0QJKp/l0LE39BwH3qlPidpVHZUd
         8drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GVzoIRFx4d8U2lI4YaT8ti2726pFUpvpJ2c4Ljdmqrw=;
        fh=w21ypD+uicwwMHt6c80bnrcYduosCgImcUcAr3mq994=;
        b=LU6/UPgrFs/dO28kSFyLIMBx//sV9MZNcRukS+7FZ+4xsxs9mr5Q6/VY5tdgjbAPwe
         AB6/q6JNzNmNgzEm8eknZKJhKV0WwjUKc24NSXb7+4eOClXwBYr4tPMQ4J/bUZy4WDw/
         zivWlnM+Gt/aEP1eruOIVLZD72yF/5N665iITZg+Zs/M7Dje7yYsFA08w3+LFpinhgaJ
         0c+GHoTU/prbuHOgVJ9r8RSmwI/S+ys2W2Jlpf7lJNff/RwVINGKI84V9TE/H3rHJ+mq
         yBZULjv9jsL30Qztb/rzmhVzwimixwTvylKjeDMxuMA66I9W0hWx4ureSWIHUulbCzfK
         ncfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788906164; x=1789510964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GVzoIRFx4d8U2lI4YaT8ti2726pFUpvpJ2c4Ljdmqrw=;
        b=ADQf+IEV+XTvfyOZlkBXk3S4fTCk59irlh7V0Vgz8LieQe1WKobpUp+7TeDkoJ76mx
         8mIJ/npiXnoETDfvS6WbgA87KDj+3dSJwb3e/J4fa2YFqZ5Lsgao4MOkJC0BQz5tgU3c
         Xsku0rCwrleZpGcAdWHfc+xrITFND0c5jKlBPYlbhlKdeTda+Kv66Cvc+WWzMh+RVRAY
         WyvBvpjKTEsXse5yZvjrGXcqNw54HDIgkudzq0X3pXCQiPidmVYk74o4l8Wm3Xv3bMI0
         kGR7p85aRkPPMEJRrlbbC5lb5oUXjMCv/EsGgzTkQAYSo0EZoHAxR8r2Rv91uQvYDC3c
         fMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788906164; x=1789510964;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVzoIRFx4d8U2lI4YaT8ti2726pFUpvpJ2c4Ljdmqrw=;
        b=Thp1azg3dZ9Ns71XqCP0L8uAXBPw/b/kF7kjJcAH1I82GcPoxA1bmSexN7bMDxyW01
         y+5DL6sf7udow6QR20SiF0sHEXCaoN86M9YsiT+6RQVEjLQaZxLptAQj9Rw1hBx2oEeC
         Fb5LXN33mhaHl5xJEKTxK/nrNlc9qAHVA+/RC97TtckjCIDCkIuJWcWP/lh7tYsDtZnD
         Usp0ZqmP2oEe2FYtRdAetc4GE2h7ExWVw4okxVsg1HHpso24LWBA43pfCqH/tR1adhUP
         Cv+1TrripoHyIuY2fOSpFVAaKt8SGJUq9VGUscpEx+Q7d2UDa/qKi+nFL484WOZGdW7L
         Xiww==
X-Forwarded-Encrypted: i=1; AKwUvBxEYZxdxjYzNqQjAGy4bVW1TMGE5kKiiPOwUTdTfb2EtuQzQFIzLsB2hLsP6wmpz4ZMhIhTOJKIHeHGO8nETomcze28ZS0=@vger.kernel.org
X-Gm-Message-State: AFuF++lx52eEBa0FflViOAFu8zklivsIyJE/dFzrf0xzUVAMvpRRs5Wl
	e7e5HW/IqQdjIjQS5lOJRsNrA0e8Ow7XTozp/8mn/hzoFHbrEuJlm/0V9ZGrI/QHhIjEMs5L6j8
	9v1NJqwtDKbyZIolgKa1j+pWsZLPn+KRKYT0SXdZv
X-Gm-Gg: AYBFou15Kj2BnlN26Gk1paP153aTZ0Px53pIalgjqpr0aIPPfgxYcGo7NJUJwGuvUV2
	dIW7kG+Qq+oBPZYhnUQhewnw2XTRCEuzOz5E78sWUNxzqMMm/WovN/7aMdXRt2TQztdltaSaZKZ
	RO0mB63EFbHYL/OfSA7kGLRcJ7dOvWccL0tvnFlEzuTJPmoDhKNaF0ALhriJMBO4izf7tHhetvv
	6Fs1HjU420IhDLGT0gjg3P+MZcAMDhilF9v9cDya2IdbV18Rqm1LbhiFgBj3DTjgu7NHiFTFsim
	zp1qIuP4J3ZsAM2yYBTbDiqHJteCT0UWXeEXQZfDpCDuT42mIzUPXHZg6FmW6hDXY8OSxUMiojM
	L
X-Received: by 2002:a05:6a21:339a:b0:3d3:adad:f171 with SMTP id
 adf61e73a8af0-3dabb2435bbmr3228521637.19.1788906164497; Tue, 08 Sep 2026
 15:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com> <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
In-Reply-To: <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 Sep 2026 18:22:31 -0400
X-Gm-Features: AcwNN1W9OmnuMX3-XMMtyTUW7_31O0rrjQ-nOjsvHKE7uL0nofLludafyjIWJ_s
Message-ID: <CAHC9VhSmpwpvjVPaEKVVA0BnYkn1M+-f4wYDb8uvcL2MQfH9MA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: verify mount idmaps reach inode hooks
To: daan@amutable.com, Matt Bobrowski <matt@bobrowski.net>, KP Singh <kpsingh@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
<devnull+daan.amutable.com@kernel.org> wrote:
>
> From: Daan De Meyer <daan@amutable.com>
>
> Extend the BPF LSM selftest to exercise create, link, symlink, mkdir,
> mknod, and permission through both the VFS identity idmap and a real
> idmapped tmpfs mount.
>
> Record the idmap observed by each hook and verify that every updated hook
> receives the mapping used by the VFS operation. This provides regression
> coverage for passing mount idmaps through inode security hooks.
>
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/test_lsm.c | 231 ++++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/lsm.c           |  79 ++++++++
>  2 files changed, 310 insertions(+)

Do any of the BPF LSM folks want to review/ACK this patch from Daan?

--=20
paul-moore.com
