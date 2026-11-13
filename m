Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564784;
	b=DN9k2OEZ0MYFOgAff6yo42cKaMN/zJTFZG3PSMzcKSumHsIgndj5Khpn/5N9qalSHdgn
	 FDg7AxBYH2BJO95b3J/GNxhB50hW0eqTtZXYw4NxOcsp+xG3sMzBinXwME1pJbo6V2dww
	 qSt5Tj0c4Ct/3Ln4BQOqnhUzYAUvkO9su9BuicZpVrzwyj8hZher/Mnr0vfcUy710mrl+
	 BCBFFLRqBiEWBaccFRSi2vW1PukiEHYzxlO+b26tWpEMYJ5YujKL/vBf9HS5v2ZhdrLf3
	 5jfh8FQoJj8GKPNqdbpTHLuOW6Kpw1TJFJ6szIzVnFxilxrgFjNfSgryUpXMO0gBJvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
	b=mhsPBWuFw2DrTkPTMMvGmaMavuY6uLV4woTbk63d1oLSiu+2gnheoakpfHaUDgAAsxFa
	 F9FGCGV4WQyy3VCAwh1ihRSA+ROyZ74sfnoumzP0sZ6A4lQydkFQxkcryNVdykRoXG3A4
	 eAVasW0NuSt8KkugYsBmYcTi43m3wVgWpDJuOq9zQeGWO0OENAQgRySTH2dehJA76tLpq
	 Gtev0ibqghAbcu57sWuPN3bieQOCrk7kySkRfG7eb/hx7jqMxmDJ9I/AqaqTBAC+bAUft
	 5COuPlUecuOVL0WagtHF/++7kLS75fYyit5tlt2zZO8qeIzYl37OiHVmeLKe0H8SQJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qhgXZLcH;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D8606A336
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 10:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A4D8606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qhgXZLcH
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso13116825e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 02:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564783; x=1795169583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=qhgXZLcHEG/xp1ftPxi4Y+VtkR5xPsdZusiH6E7v1UVOpu+pQQwW0vkLZszWZiEzcA
         +BIaLUI7scE4yUL73wk7QDgrWayWPrLwdz+Upaai9wvZdfIC4mpAyM7/MboFd4cm+sgl
         6S6dsMSsgGsAMWrOW2SdAqPT3x/sY2fNDxpywpmU57N6cPKU4MQNdvXTLk3fPNzTNPjQ
         TN2vMd0rw8z+5ZJqFwtlFaNorLJKFpgZtePYZzAG9uux/UTV4iwPxrV7Aluh/WlU8Te+
         mKwCC2bzY5T7ZateqcC/h9wnCcfLq6dmSfmWCE2kpyRSPYXephvqiHzXHW2gW5l+Jqy/
         ZrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564783; x=1795169583;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=ZHVL9m28IcviHQpsqwW+QQav7zt+w2l8Woe53sVyh9+wDp7EybDy+YFFWbY7cW/eWN
         BBRzI/0FUSzJ0PmcbXwAe9r8HZ04Wd4foqSiD8jVst97PRlmac7qwzDLxcvHnZOpFcg5
         qqUxtBuhgnZB9IyVM6UHQF8Y/gzGCofeINJGq2Ejtp+RoLIMWiIKnkbQ9OvcYv8sektn
         gqE/kjZQWhwfwTgKaTOs/Y8S0fd4+vt/h6bXSiuwPx3biFrfwZBt2XKTdDJSrM8dOjXD
         30cO40K/hccT3Ue4tt3wVwlqY2PePT3nP5YSBu62Dz+bHHI6UF2dClbYUHeuma9I29eT
         0WSA==
X-Forwarded-Encrypted: i=1; AL+hErEhPJ8im7AUsUt6ZG89cd2fzJR3oLxECYNhlvc42yIesVW3ESKI0G4X5m3RSKmgSr3ErT+H8CqxRZPRBiRKsxXDwMASDQA=@vger.kernel.org
X-Gm-Message-State: APuU4Z95evYDV1k/wU2YBzIm8AU3yWRXa/XxsRjjCmg2GsRBesfcfwhv
	5lHddGhzSP8eq5J32ycQ5KxIpl/WhUPUeKLyLrqknrPXweYUluK5NiJjsjVoQ7AMLLi5
X-Gm-Gg: AYBFou3hJej0IoEeq1Zod9Ne7rOqdvfHGoTTuJj/elPvy685v68uHn5DnRRrHHHM+t9
	P+0TBSNhpYrYJmPdkA3liQJFl7Uep3K7kGKwgVz0hOI5LYaz/D/chTnx1Tgzgdk9fjdSr2D87w/
	lLafh2OzeFpgeDMPCmMkduZ5Okg2DcKptDUR/+zgbIiVPohaGLzBBoGonDUOy38BhtTQwm7EM4R
	TFAvDnamq+o6efI7Ya7QAgIGvvtR02gM6KW11gNjMEMNIeCj+nURZIl0/Ocai4NdX4cLPDDtzA6
	Xd0FF9iGV0skNowu2j/ON2+k8lI/Zks1SomEXDv7vunt3jZ2hBQIVRhr/AuPyYNUjhjtSVcB6k2
	8mMdslE30LasYHP4L/OR3Qi3IIi1apLcnljFqlYceShXdbeyrV9alg/EwyVeRHNxSiYmj9HbtpV
	FbH4cOoLT8HOlWsGMtcboAQeqKhN+fQR+kle1fXOyscgwU8IcBzx+160b2XKzpoToBlLaTGOFh1
	9444K0QSqMUVrdbwj2Js6tM94uAsHy6SGRu/6Y6DK3ZXr5P5uwjxe57RD77mBdYl4gXoezYjwpl
	wHMjH1l53WsZ21xORLGvXzFmSNwl4UiByL1v8PyMztZS4XpxELnGPLO4mHipFiqW
X-Received: by 2002:a05:600c:4f90:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb55a47602mr36814615e9.10.1794564782834;
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5d2872edsm4056955e9.12.2026.11.13.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Message-ID: <94dfa5ec75f4479663dd79f3ce05c1dc6c080185.camel@amutable.com>
Subject: Re: [PATCH RFC 22/41] sunrpc: use fc_init_pseudo() for rpc_pipefs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:13:00 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize rpc_pipefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. rpc_pipefs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0net/sunrpc/rpc_pipe.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 9d349cfbc483..37277a6d2415 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/kernel.h>
> @@ -1181,6 +1182,7 @@ static int rpc_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &rpc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}
