Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AAF3B584B
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773118052; cv=none; b=W9iCJpXUIQiZR8v1F/dFbrsGsyuSkc/Rit+FHxsKE6ACVLwKUQqgVm7FOS38F5zSCQo2up/tY6dxY0zwk7LQ8KmZ7tP71m1+7waLuenwZNMmWE6NzHx+LUCl6gqdnCwRMKinNOqFoB74f65QoZfMa7Mh7tVxckqXueo6PJjTGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773118052; c=relaxed/simple;
	bh=RqKqnpTcfCZI3hFTmKFbeJPUk2jsyCxOq5Hii3rlEWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R10DDp8WNrE7Amgpbmly1eaZI53Obk+YWiew8IDKjDFmwGNcgDrd/Og2YAe6bpCnFfreQD5QyatiV7xgLdFksukKa1AEu2lAxWrf9YpBLJrj8BB3EA+NtPIU5QmNB7V0dxrIwqc+KYfWMhGMhOh23UwWtgNOsDfgBBoeFR8koTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubzN8uNf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubzN8uNf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65512C2BC9E
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 04:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773118051;
	bh=RqKqnpTcfCZI3hFTmKFbeJPUk2jsyCxOq5Hii3rlEWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ubzN8uNfufxX6KIDipsjLcZc1QGTqzMznJ0fg7PTaJQaOlJABMOIcN32NE7TQFxEM
	 de4WIrOdl6Tr4Lil9IYnl6KX7qIgILUhUAq78Ps2gixnVh9zDRzz7XkBqGI859rFgq
	 wpai/85n5rJbiCm9bkyISlnFNFvCreFzUhiw6gShnQ+DS8wgV1YJuGTHJdbWi3LtdW
	 IWkVyt7PKYhTkx+MH7E9ARKCjYkG84nCeqWMDWZPszfI8E5D2HDFc5ZmxpF3ikHrcq
	 QB9UiQbSeJ9U+OV0sm0RHbJRqsZ6Moo3k3X/jDeHo2Wyg66hyAVViBEFK2tggSzZFN
	 uXvI06L4dFESA==
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12776bebe9fso440895c88.1
        for <linux-security-module@vger.kernel.org>; Mon, 09 Mar 2026 21:47:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFLiHXeG4R0euWgReYnKIz+xMoVh7q6KaKrXqs2RmaZR9vnKeHHyIEVoJIlLN7IM4ZtOQk3SDLo47KVGs+SyZar8M7irQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pH7ua+ywAnpRQz+ykRmNClqVwjyNOaOPRotyRttfZeV307fI
	Bt5wtmSTBCclDTuYiKeCEKWDUAmn6reVsNbnK9MGFoU6LWCrpMg5aLr/RVMc50/nXCRm5HLqaFy
	z9AF+6SIlkPA4YZevPerDg2cRjefttUk=
X-Received: by 2002:a05:7022:698b:b0:128:d967:4674 with SMTP id
 a92af1059eb24-128d9674d0bmr2199641c88.19.1773118050845; Mon, 09 Mar 2026
 21:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308180734.5792-1-evan.j.ducas@gmail.com>
In-Reply-To: <20260308180734.5792-1-evan.j.ducas@gmail.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 9 Mar 2026 21:48:09 -0700
X-Gmail-Original-Message-ID: <CAKtyLkExDU8=ovSBA8NLhzTBy393A8KZYZ=36VjkwKOj6FMTAw@mail.gmail.com>
X-Gm-Features: AaiRm520XhD3p6NGuquRd2scdyWe0zt3ypb5BgKWqlcD7X1YAnLqms7wWEn9lH4
Message-ID: <CAKtyLkExDU8=ovSBA8NLhzTBy393A8KZYZ=36VjkwKOj6FMTAw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: security: ipe: fix typos and grammar
To: Evan Ducas <evan.j.ducas@gmail.com>
Cc: wufan@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, bagasdotme@gmail.com, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 11:09=E2=80=AFAM Evan Ducas <evan.j.ducas@gmail.com>=
 wrote:
>
> Fix several spelling and grammar mistakes in the IPE
> documentation.
>
> No functional change.
>
> Signed-off-by: Evan Ducas <evan.j.ducas@gmail.com>
> ---
Applied to ipe/next. Thanks.

-Fan
