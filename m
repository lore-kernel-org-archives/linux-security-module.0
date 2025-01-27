Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688015B10D;
	Mon, 27 Jan 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738012051; cv=none; b=fq2IxZ8G0Oobo+9FB7dOmuKl4U8cGZH7hXuLGlRwGQMblOLKdwshnoB6S4k3VCCpQ+Phk1LDMWSLEQ3XcwSRuG7FuFKiezfjAgCe438aVY6Su6fxv5KH+XFOPbWmwTWi2U+rcB5y9S/IMBL1Yfb5Y1ABe4H2C45lYudvNkGN3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738012051; c=relaxed/simple;
	bh=Ph4LsKdDXKgKXX7RKxCai5H4EMt0LF9SZ1cKR8yZ6Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkPD3XmAf9ZACa0VwJ6cqUfi6kILoY+hLZ9qDAC1qgP+DJjGPeJoMyxvVYahmoPPyhh8AWeYNkQ36Mmlq58CIy5Sm3zOkhD/iDJY3cXbqLV1A3dbI2ocF5LfvfaK61ehbyrMbNRZz0priR3NlHUlBkiOW1iT5quvNigN2UwWG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji6DAwYK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji6DAwYK"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso9407118a12.0;
        Mon, 27 Jan 2025 13:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738012048; x=1738616848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph4LsKdDXKgKXX7RKxCai5H4EMt0LF9SZ1cKR8yZ6Ok=;
        b=Ji6DAwYKwCn5emZpn+RjE7V92TKlCFwZ1vzSkPK5h4u4DPWu18cNK81r65iLy4bBzk
         DsgMgLDgng/GfU44Dae1CHtYESdI+IIKNgxowPURBrYMtMXq8NhqgpLemuhZ08F7iLI7
         0ZdntcZelqD+fmfrYxYuAmmP0GEqLqs1nFUDh4u8QWbCtnv0cAlkjaV7sdcmAclJkiE5
         jktVIXZrrnHptTXNIZ7+53A9GC+rPaskltx+8KbZykaLGCXmZcw6owgSWYN94f7LduqH
         Mni2H3u+Yc1TT5k8ArqtgGElzC2a8KXaMZ53jlmIBtS2U7dRZpdDQSmuwmjmt+sIoh/U
         ynMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738012048; x=1738616848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph4LsKdDXKgKXX7RKxCai5H4EMt0LF9SZ1cKR8yZ6Ok=;
        b=mdVAu7wTYc3M6sGR1UgF7qfbvM5b7CRlStc6MOfXbNXCZw1TSCU/sSLdKsySx2Hoaq
         cc4zDbPsSrlqzeAq4/E4fLWXzXplPGa/kX5GrxQLkgiHvQF1vh+wDVUUVZwdjX0S0IHO
         cfbH9NEZb1MktOs8OCzsusYC9vA97z3D2+v593lDgEOkuEVqJnmgzSXiX6+Mn2EpllQW
         fFAWdAvk69sTreU03flhCPQD5/hwKCFIh5XR7BG52ZLidzEr5t03esVNwwaQfaM48vdD
         3K57lhneLjWg0+kCd+4dNrCmvLEPUj/AWsgDPIR/IFxLHjbgWjix9l5sm+DgpAurxeH2
         dYsg==
X-Forwarded-Encrypted: i=1; AJvYcCVykhfa0ht79KaMWMspwt4pysVqUbUZSdb7UkhwJu4s0+TLURDxoeBMYrGmmVnihJtgHCAcZKV5E2tZg7A=@vger.kernel.org, AJvYcCX7r4Dp5vLpb2TFin8CGcFPn6rRWK3rcOoEV7uHScN+yi1kzrvSKWjFOc/1JvU2bqQbc9duIUKovgHvcj5NjNOzbNK5lKoe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mOnTXL8A4QnVY/7ToMfyI9n+N+C+eQPTgTbln+aDbdegs072
	oeS6TE76KVDbU+7KbTIW6zdDOAQt8jKMcs3cbWQYx2e3BZyid/+c3OuAgVobu3g+0hy5MtW0qbj
	YlssyVD1EDryEfSLKGKUIGhQRv/o=
X-Gm-Gg: ASbGncs/twxNYiZreNhSiLW6JW5bJ8DUqeXvwLJDuV0PAXKlvBie+ROEbIBf0IL1GPQ
	8jnzsoJLTqEYhaDOv1N8PaAtNmA8zcpzm8gh4wyktajjdDNIXpjVTt+O6RxGo
X-Google-Smtp-Source: AGHT+IGmodn64v6jg9Cv8nLWcX0huPpc7OBi3YIaBJcUH/6N3ZHtxeWvia8KzgFkiOs4wChlFb2f5eK+DOEq55qyDA0=
X-Received: by 2002:a05:6402:2548:b0:5d3:e79b:3b4c with SMTP id
 4fb4d7f45d1cf-5db7db2bfebmr39227226a12.31.1738012048458; Mon, 27 Jan 2025
 13:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127205404.3116679-1-mjguzik@gmail.com> <CAKCV-6sRcOOcLOqc62PyUKqbmmqTOje8vf0kDhLdNKaa4r57_Q@mail.gmail.com>
In-Reply-To: <CAKCV-6sRcOOcLOqc62PyUKqbmmqTOje8vf0kDhLdNKaa4r57_Q@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 27 Jan 2025 22:07:15 +0100
X-Gm-Features: AWEUYZkLfzdxeZl9uzdwZlGdlO-dXeXwY2yysO_AO2CXFVB_zMJPJu1dfcnNRaY
Message-ID: <CAGudoHGswaubt5-rYNBy-whuf1_+F_gji_RshfM=hmXFF-58qg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: use the condition in AA_BUG_FMT even with debug disabled
To: Ryan Lee <ryan.lee@canonical.com>
Cc: john.johansen@canonical.com, paul@paul-moore.com, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 9:59=E2=80=AFPM Ryan Lee <ryan.lee@canonical.com> w=
rote:
>
> For the record, a previous patch that removes the sock variable was
> previously accepted:
> https://lists.ubuntu.com/archives/apparmor/2025-January/013449.html
> (patch) and https://lists.ubuntu.com/archives/apparmor/2025-January/01346=
3.html
> (ack from John Johansen)
>

That makes sense, but imo the posted patch is still warranted -- all
other debug macros (WARN_ON, VM_WARN_ON etc.) are expected to evaluate
the condition.

--=20
Mateusz Guzik <mjguzik gmail.com>
