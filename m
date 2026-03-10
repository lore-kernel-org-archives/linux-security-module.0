Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD33C6602
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160196; cv=pass; b=b2reO2ewPnYwj4ReZvk1T1pqFB+TJKB4jStbR5fzLpvMOUiOZXorq6V+xDoL0DNCu7N8I3XjtgZRj5VXAvztrFzNnoEitY2s71X7gwBbIyBlfCcGpdpLc4suR4eA3+VVTOGvdqyZEHYAhyRyzE9uWX0pOqpoK5Rkzd3LBhn6710=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160196; c=relaxed/simple;
	bh=GtmCMbObKbjmmDRT3XldbNlZvhgkpoXsfeQtLnlwBSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9C+vGEZycpMdvbvKitUHOItSbcttbvjGTZKkaiPJWQUTL8JVk64wgyaXFVeJtt8HPywidlgDoMuNUCMpoPdMmRfEWv7LaAUuaVmN2WVTIc5moeZCArLar0gj6S1tuKXlXUJopNjg67e19hLUszAXKmkIpUXJ0ua132vVN6x46U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIi3EUj+; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIi3EUj+"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d749f99691so1276915a34.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 09:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773160192; cv=none;
        d=google.com; s=arc-20240605;
        b=YfdxBrGvJ+fXVaiUArW3TxAL7SugNhZ2ZpYQ7NYjnO/z8SONowJFatxdFyoQFiZfOo
         k9srWeeTn3mgeByxS4J6XmBE0+Zs2BEGNPoU2yC676lSTu+fA/qEzZ8M9luFjMd1A5NE
         GM6Lc51f2Hh9S/KYjlj7LYvgonEC5f84oSul/3FzC2RP38jQUlZ+i+zPHwnkAZCE95Ob
         9JIiWZ7vWZJkkXGD0xGR1O6M6GNWdlDzGO+Rs7f9258+8bwAHCHE+mp4IdZ13rKUvHSo
         Z8/hCJysniudAzwtR0eVVSwYxs9hc8VpJro8WIZ0HPUWh6+JTNZQ6NHjjqZjW+ewwMj/
         sZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vO7Rn9CkKo7xlP7yq6/bQIjIhq0HvuTasre/UqKYfjw=;
        fh=sKq8BTU/61SDGWOpB80Qix48I+waPUvsymQB58Hu19g=;
        b=XJiSWPSDbNnL7D4e54aX8bl1oTCqU4qVtOFG6/L0MkWlXkOwNUf+IprrzTjK5m5MiY
         7hT6FxAAs9+U3wWPjJ90iKnvSYnle5WsppoisgQFo44TJy2XEbLrG9T98NHqRpPUsjpo
         ord/9wuY40B7MhMeMZIcbxcainoNwlA88xTDbXFjc0y5gfOJ0ZdqZp3GucWZ2B595nvb
         E0C/nSOVc5N6XZ0P4I/03Uc4hW5gikydJdFCEZJ3quRWlF/HyWF9mOJgcrThs2neAgGh
         rD8DBmz0nmMgSDz7HyWpKh8rLREdNjsZPROlsOqs1rT5TcBRQ0R3wD59/DwxiTiTM3Br
         5UFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773160192; x=1773764992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO7Rn9CkKo7xlP7yq6/bQIjIhq0HvuTasre/UqKYfjw=;
        b=aIi3EUj+F3utEyf1EUmD6JJtBYGzA8+LUk70HHFXsOiLpcNTACiRuR+YwM37at+lkD
         lpOP7xxNfmS+zh6Jmf5aaI4WkxBOJCYc+id7acNZzu7xD/bHzGcgn+q+t2hQsc4FFvho
         qzvhyzdVWsDd/7JtY3YOtlhO240WWp+RBng4iWfWEgaFL/+qmNNohdjkL5s0oBUzwntr
         0BJDkxz+HoZqEDr+uwnnDxiS2yaQf286uymt/Z9lCIUnWYvfa0wtk9RAXkteBqXMVljF
         a72IyrKVYOdB9Lthg9biBFnYkLgX1PNmznuT0IwFGcP3k9xTt8nRMx9B8NxAi2+yIUCa
         sO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773160192; x=1773764992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vO7Rn9CkKo7xlP7yq6/bQIjIhq0HvuTasre/UqKYfjw=;
        b=f/D7pE7icMBPD9TQp1g4mYRGKue+imGuoeyzRhNnHEOTTVKc6jFkrwwQSbxJ58VfId
         tosajyCdy+9yUXf7FpDBuL3w5AF/AtJRltjfPg/Ndc9gYQlt6HVbK2PULj1/l47lUR3A
         6Ixu1f+KZSiyesXVj8q5bYzoLucO/rXa8AyrasFlIPofsCzPIxaNKKvI4QYaAVplLQ5L
         ZOvBIEbGVQfwjkFYv8IXcd/vhMWIJ0jcMVA399VG6gYuCbXkv8XGFqNfDhxe6UtaaBZE
         gSlxL+RKUIXvcMZ/cQjOyg5Z/94J6XJv91cz46sGB/44C2iN398D3j8M2k+tMP79Ah4i
         GyRg==
X-Forwarded-Encrypted: i=1; AJvYcCUFWtgNLk/+0yUkmqo6uWayRxcT/B/AOpE+GDRMphE29oBu+DUFTKm6j04xLA80MzlEKtP4AFZhnJABTyVAIhQVJmXc/GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPiVCgiAs53bmdKj3KZ32kUVp0f4bCLjrx86huAomypY+jkbE
	CdJWkJQg7U+/kW0b6gxqSmCmBjET5ojks5yMMR5xHmOv0P4nqe8Q12vwYasYfHacT1nG6Lg60Do
	xY2Lf3rxiV7G9B/BwTgxxeY+511bXuDA=
X-Gm-Gg: ATEYQzzxsk1lYrXRZnKkVjF4SPfhXON9XmlBQ7mJT4haMS4xGVhPEXxRmhXiXhz0ANd
	xPqhw33iP3zAEXVi87/1xNhaMPb5GVVk7MR9Yu11YcllQvDMNfun259ERimrh6G0lUXAk0AIPai
	CWuuI1ArVXTLdZO3LxujW7/MoDlmPp/FXJceL6a+u33OqofWlQku6pybYqCBgL9wr4hnMziIF+/
	DjerwGvNG7/QjipO6LztmbwcZzWp1Ffk3PQmxvwZU6a9rgr8Ze8Njs4Fa4r70e/jWsyq3xPuj99
	RwUKQxI=
X-Received: by 2002:a05:6820:f028:b0:67b:c122:d2b4 with SMTP id
 006d021491bc7-67bc122d8d7mr1047833eaf.62.1773160192035; Tue, 10 Mar 2026
 09:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
 <20260309193743.GZ12611@unreal> <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
 <20260310090733.GA12611@unreal>
In-Reply-To: <20260310090733.GA12611@unreal>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 10 Mar 2026 12:29:40 -0400
X-Gm-Features: AaiRm53wKn-Z9Bfyll-JSQgHDW7M1uOer1Mv0lXwG0F25zaRxhNKjMHX5FTwCwE
Message-ID: <CAEjxPJ4nTmovpgkzC+3=Oh7EAhpi1vHLwJfjezu-vzX_Q2OCug@mail.gmail.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Chiara Meiohas <cmeiohas@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, 
	Edward Srouji <edwards@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 5:14=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> 1140         MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
> 1141         err =3D security_fw_validate_cmd(cmd_in, cmd_in_len, &dev->i=
b_dev.dev,
> 1142                                        FW_CMD_CLASS_UVERBS, RDMA_DRI=
VER_MLX5);
> 1143         if (err)
> 1144                 return err;
> 1145
> 1146         err =3D mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len, cmd_out, =
cmd_out_len);
>
> Could you point me to the LSM that would be best suited for performing
> checks of this kind?

If you just want to filter on opcodes, then the SELinux extended
permissions (xperms) support may suffice, see:
https://blog.siphos.be/2017/11/selinux-and-extended-permissions/
https://kernsec.org/files/lss2015/vanderstoep.pdf
https://github.com/SELinuxProject/selinux-notebook/blob/main/src/xperm_rule=
s.md

This was originally added to SELinux to support filtering ioctl
commands and later extended to netlink as well.

If you truly need/want filtering of arbitrary variable-length command
buffers, then I'm not sure any LSM does that today.
Might be best suited to Landlock but not sure even of that one.
