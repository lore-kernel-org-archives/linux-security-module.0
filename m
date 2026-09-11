Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAADF46D573
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148936; cv=pass; b=MllWeVNzjCOj6dOQdyjI2c8oLLNxEBdbNbiCU2Yq6s6dTfxw6XTihtIGpCZXHaVxhIpDhGie0pfXZPH9spmoOaCzImdUDhsLj2Nl0hTyMJRUsrj6nBbpyzemO760jVOxkuNFgD0d2D9Q31v76xlT2ybBvJxTUvoNwqzq8rq+610=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148936; c=relaxed/simple;
	bh=bGLEgwaZgdYTaYM4USIx5xLZ8RRcvADu7JBWtlF3dK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nDnBSz6Ef+czZE8SnCGPkIAcFGFa5PAF9C2bPmbeLhbhmE7mNNAsKPYMyl5A7+Y3as/8OLunbR+c3Jh9zk7XxogNoLbi2dIvH/B8y1FPTor1hq7oC3Fbx6Hy1qCBa7mWMrWxLqDZkeGDMur1cGIFBzyAHkFz/BZt9G+Bd3PosD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QBW/fSE9; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QBW/fSE9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d6fe26ef1cso16566555ad.2
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 10:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789148934; cv=none;
        d=google.com; s=arc-20260327;
        b=EeuZo3vWQ+SHDz8/jnKw/XbEDYCNN5/sVrtuDJ/6HGfaeVntnVE9qaYQID41xsRC0T
         XwrtKTs9rgUlm51/45DSb/CXHaIOepTzZfjYeO7ggr8J+q36vxKf2rPihxgZhZs8aejo
         dJ8Zbo1cExF1ZGsBIUUPxS2v71Ezh2OoOKyEEo7lz7/hYgHEgua21F9hFbbB28lUDYte
         3CNENiyIBP0jx7f9/6bGIkh5b047tk9fozi+hekhDvdFJX+dpWCIJsLEiREWPYELpbpg
         34uRTuwOUgUl92B0S4Tco6UpO2IyUP2yZeY8EHrHpfh3FvCZqIvxzyM7WfB15EjBlFD5
         t/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3CLJcEygTjkQvOeGhJ56KYzNxUmuL7Z1pfv45ziinrg=;
        fh=HWvxphz3B4fT8JW5akXgsvoVKYyqQiWIDTVLPji7d0w=;
        b=qeYJjcocjDp+D4pSVuZY3TQyGQbyFFtPITGVWjGvwYrSlJ9HGyBEMicXHL6Xuzcd+j
         7D3+QbwDAlA6SluuSfOU9HxLzUL8Mol5wcRdEu/dlgOTXMr1fQ4Ojk/BIdpZc383maWa
         ubTVb31+kMDF1L/w1DhcvG+fSwjt24cyBW3+tMdBXF8TQifeeUnCv0dwWGhR0kkhAEnc
         wEkRV6fXiGsJPFnyJA3rvClzzqPepHA9LxkQxCchVIwqLnLBB6a4wnJkRyY8FEzPzmnI
         kp7vELU4CLM443QsR5fF26UVVLUGfgSsNRxTbYki51ZaSo4jo2Naq6ny1R31dPxw3tTE
         LFcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789148934; x=1789753734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3CLJcEygTjkQvOeGhJ56KYzNxUmuL7Z1pfv45ziinrg=;
        b=QBW/fSE9UPJCNcmsbPMVPHczfxmDn4MBZ65qnztgGufLF0jjlNF+iALEkw0/wK0Rvb
         1u2K3ohYLGvsvWhz2UU1HqQy7NELOUNZbDUkdIg32sI6+jTTEUUSwhNG/mYvu3hrhP14
         a7xPrgGfqOQNDAQPN8Z11G8QPybcXSPSqg0YDFwWT96d4dTdT6ydQMy0X3yzuU7aGbJ9
         d6re+9vFg9g0slNv7a8YtXd943sLGbyWe4PH6Lvug759+hK3Fk2vlmZHUmfgTuPevWo1
         JKfulE5y1FyIBDZaSKyXQp/RTcqJNw3VlBCMDdfJFwK5OCziF2pf/M1TECM2o//leWZw
         zPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789148934; x=1789753734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3CLJcEygTjkQvOeGhJ56KYzNxUmuL7Z1pfv45ziinrg=;
        b=UUgQW2oOsXOrkwvLw+txX12d9lXtuGCB6WQsYEwS8xVFvacgN2/0VTTP1lkyb8RdxP
         OKN7Uj61+eIAsKhX3iO4AyttbNnWCY54E2WIcfyGUsFzYYnGscLVhV6VTGY/ldixqqsl
         UPo1guAl8S4RFNxRfso37+WZwcnAeTf6GhkTV0It7qxyLHEyf6t9MqMyc/8jJWBHia7q
         fzDLsgMamj5sNxTIBuXauJ2vxf0MPneSbEk/u9J/pN2f2+j0eTqGN08Uqg8WRprJaiv0
         5C4O0Ms4hoctG64rnVvAHVkFHw3/AB9mDmfLnAWCjJ3UzON7fftDRvxVz5dvZaNSx7hL
         J8xQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKsutFYocq0IzlQRg8O5DohnVdY/kRCUQVQU+ZMQ3hBwp5yQE9IoEeZYwt6W0eT62EzceXq9VrSbArRqV6pOUMKHbOecE=@vger.kernel.org
X-Gm-Message-State: AFuF++n8ivR1npG5x2dTQ5JeHVs2+QEBxUcCSlNaFedz/frbL3834/M9
	bT+siAc51Ad7qPJj3M5Rh0NXhrWvO5tVEOO7wVwtmz9Cynqu8UtGSEG0JRzB5QZTnh5pECdQVbT
	Lys0Kk+PW9lYAC3UJ6oJ6nzZHKJbQn4nIAqjqmEqq
X-Gm-Gg: AYBFou3T0szyGSNLJNcOIhGk9k6VdhhQ8eaV6TKeHPMxVmXBnGABne5KplYLCjYg5wf
	AKqGusq7pHwLMUvzdTVIIPzTIZIcOeetkiz96PBIP4mzT2Yg1nqf7vI7PprDqWCthjiGaaG2Hp3
	j4GXHK7yXm6hdsYHuHtuGNxTpuygyfsEu20H+6CSdI2eHdXz8OiA2QI2cnOM0YdL2IITq4lWYfM
	8iSw6rY1ZzuPkBOJ3SViZcVkpeMqH72u4VhJgNcAljVrnTZDAB6RL3gT7zpvQn/ZruBgTKsttT6
	a+0Lo06KBQuoFG2cqo6M4pywb7b8HxGefOkabGIpIOMDFkGiDslcuEhRlopCfTXWfRfqbO4IFr9
	yxtmNyYVaqco=
X-Received: by 2002:a17:902:dad1:b0:2d5:e3ce:3988 with SMTP id
 d9443c01a7336-2dd2a33fb90mr92851875ad.11.1789148934087; Fri, 11 Sep 2026
 10:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com>
 <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com> <CAPa8sAgVFXz4ZX-OR3YoRM3cOSqL613NnpWfgsbKiPjViOziBQ@mail.gmail.com>
In-Reply-To: <CAPa8sAgVFXz4ZX-OR3YoRM3cOSqL613NnpWfgsbKiPjViOziBQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Sep 2026 13:48:42 -0400
X-Gm-Features: AcwNN1UU6zUyGDWy3WYAod5nfNhmzEn1TsvRMrlE4i5DL634iZyubVBEdQBn6lY
Message-ID: <CAHC9VhSD0Cdot=wy3mVyxCCD5uaCQ_bB5EE6omDFqyJoAMPG9Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: Daan De Meyer <daan@amutable.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:31=E2=80=AFAM Daan De Meyer <daan@amutable.com> wr=
ote:
>
> > As long as you are okay with me updating the patch with the change
> > above (and explicit on-list email would be good), I can swap in the
> > paragraphs when I merge the patch so you don't need to do another
> > respin.  However, if you would prefer to do a respin, that's fine too.
>
> I'd be grateful if you could swap in the paragraphs, thank you!

The paragraphs are swapped and merged into lsm/dev, you should see it
pushed up shortly.  If you notice anything wrong with the revised
commit description please let me know.

Thanks!

--=20
paul-moore.com
