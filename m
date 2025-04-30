Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85D3228CB0;
	Wed, 30 Apr 2025 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055496; cv=none; b=m73d/iBdOEmp1AJv0HHWuOx16yh91tKQuMZdTRX0i7ZxsiImv0Ungrq1F5ZLqCnazF9MhK9g6tEwFqaA9Gw77Bz55aE7vc8fGK0EWAid/GJRLiqeMKTIxNAci2YAFUYpsfHcY5MRQzY7v0MGBtsqzZFJy/BPyiybheqJyb9Ho4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055496; c=relaxed/simple;
	bh=R8qGUQj0WsUU7AExrF71Pi7VBmUYNaoJjOIObQJ2DE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pP8aMjPjNsuvD+gHTVLboAa1n9HVv9UkxaN0xBgGym6QIX2wnnfdDMG0C/ROFRvg2C97Qbgl3n5+AFxKlSkwgwxItRtP43jyXKvELEp2S7YxIRs3Pn13O0k0dstD4ndhuN8NismlLgt4a5j007tXu+WHBp0Y7CRnYoMmF/vmQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3BiiNFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3BiiNFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31458C4CEEF;
	Wed, 30 Apr 2025 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746055496;
	bh=R8qGUQj0WsUU7AExrF71Pi7VBmUYNaoJjOIObQJ2DE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g3BiiNFix/egbXCPo7ksUUBq6VXcySoXnzplC7XPI5JR872S6WOS4BRTpA/gc4ouN
	 mAW8/4FY59XqOEPXy0dRdKsU27tM9sb2+LhiuNL71UqLOfZaSUCeKQbHohNIgBeiX5
	 JrIj5d6D7TI9SqGb67yz5DqsjthTOHdF6VjeP6NH3Cuei0UPPFGccjTXl6xKuVBzhp
	 NMOyBXINMc54u1j1nN3OtJSIFNi6c0KwlPAhUzqr2IuaGSCdQcht5joCw88TjYZZad
	 7s5NjakB7Sla4Tub1+ZraUNnQm71PXMFGXkuX9pKGI/hpDRMZ5DXECEhqUqBe7WNYm
	 uBKzLFRJEK1kQ==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6e1cd3f1c5so361953276.0;
        Wed, 30 Apr 2025 16:24:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPLCl3zsog77l8ndTjps4yUEImOxZWQwe72rnH2BHOX3yIGYn46CuWaE/W53BZQnoieymngm4DsDB86NIGWbSECRBX+a7I@vger.kernel.org, AJvYcCXsdocYPd01tJ8S6XPRslu2RY2srZekIQQUF4fUDbXIdUkKz3ZXu20in0TaX/sN4G/dVfAB6L8CIHbUQhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybg0gN6MYIImXKOk/uBzedabclgU91ImNH/B9apb1I1PDU/gix
	9U+CMPy0m+gKKLQwtTD5Dx3dK90XHu3BsHKZHlWf2e/e3fDh1Q3zapexecJrLQhEqcaRQnZ7u9N
	8grj4pqleg+ES1eIu1TTAj6HTTUI=
X-Google-Smtp-Source: AGHT+IEFb5WKeTRO5ku9Dx9DwwQgc18oJPQ/xKG17qWkh8xO/tVwN1QrvsFUK7xHQwD6qXq8deenEeLjaHUpEN9Fl5k=
X-Received: by 2002:a05:6902:1690:b0:e72:d88e:80d3 with SMTP id
 3f1490d57ef6-e74f8a617f4mr1696642276.36.1746055495439; Wed, 30 Apr 2025
 16:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1745961770-7188-1-git-send-email-jasjivsingh@linux.microsoft.com>
In-Reply-To: <1745961770-7188-1-git-send-email-jasjivsingh@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 30 Apr 2025 16:24:43 -0700
X-Gmail-Original-Message-ID: <CAKtyLkGvcRP9f5gGhsSnEA28Nh0Udcq76ZZv0SA5Vko6w8R7qw@mail.gmail.com>
X-Gm-Features: ATxdqUE-PtIOlhPKHRm327Vzj_UUY1r52fOy6jBuOQSuFz4DpIQTYlqWRkzQTzw
Message-ID: <CAKtyLkGvcRP9f5gGhsSnEA28Nh0Udcq76ZZv0SA5Vko6w8R7qw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/1] ipe: added script enforcement with BPRM check
To: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Cc: wufan@kernel.org, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	mic@digikod.net, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 2:23=E2=80=AFPM Jasjiv Singh
<jasjivsingh@linux.microsoft.com> wrote:
>
> From: jasjivsingh_microsoft <jasjivsingh@linux.microsoft.com>
>
> Currently, IPE only enforces the policy operations for direct
> file execution (e.g. ./script.sh). However, indirect file execution
> (e.g. sh script.sh) needs to be enforced by IPE based on the rules.
>
> Overview
> --------
>
> This patch introduces the `ipe_bprm_creds_for_exec` LSM hook. This hook
> specifically targets the `AT_EXECVE_CHECK` scenario [1], allowing IPE to
> evaluate the `EXECUTE` operation policy for the script file during the
> check phase itself.
>
> [1] https://lore.kernel.org/linux-security-module/20241212174223.389435-1=
-mic@digikod.net/
>
> Example
> --------
>
> ipe_op=3DEXECUTE ipe_hook=3DBPRM_CHECK enforcing=3D1 pid=3D18571 comm=3D"=
inc"
> path=3D"/tmp/script/hello.inc" dev=3D"tmpfs" ino=3D24 rule=3D"DEFAULT act=
ion=3DDENY"
>
> the log message when the IPE policy denies the indirect script execution
> via the 'inc' test interpreter.
>
> The IPE test suite has been updated to include script enforcement tests:
> https://github.com/microsoft/ipe/tree/test-suite

Please use the PR link instead of the repo link.

-Fan
