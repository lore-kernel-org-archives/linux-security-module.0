Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4164A8426
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150504; cv=pass; b=A2yivGVfG/DGcruX5Sb9+D03p0PM/S7MoHEAYgeplQNq2/5kXtzHpP9uv22PlFNqS+nFy+pfAetG1bJV9Zq+lnko92ExB4T4Uh7sxvqaxu3Gtrgw5OiTxvGtdYtlrPq2zEuyZUEEPBHJb7SXsfEiV/5QBtxyEVlRkdFjPDyTb1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150504; c=relaxed/simple;
	bh=aXuYUBA4qgCRVJnQLD/3rrlsxYP5kIO8eP6F/R2gRWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMt+7M3SHbLj8O8TozTu77S1/yitfWs/YqJNFVS9mUM5r3hMrZR9bjfw7zgXnrn1NWpJ9CEQDbsWszyZVxVOJvbHlBbKkQBmqk7NrcqBeFJpWCCrsKlZyIDz1VTvOh/eWoeLkzSN/p+zj0TjlhKk8bWQ9q3LrsIXNUXy6lpXCTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NyWNpt81; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NyWNpt81"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1231428a91.3
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 11:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150502; cv=none;
        d=google.com; s=arc-20260327;
        b=FrZN1yd77OW/MGV2q1ZcFyuCVP1XFh2u0lf1+ZsvuAQP+ybVsWXXWu9EsZi8gP8i9J
         5TdP+FHqhgUoeAOwWVXp3FbFbW1qc3O/ADiBWzKY11/YF38BQUXv1Nue4+Te36ms8skJ
         tUOmurRwf7wZs2LxJE2UbW5Bn263HxRwQTRRuYJdzjohuiUd02pD+rZCEUPDWmvyFty1
         VFWC9L7R38AzrIkuF8AkmGW6aO45CRF/sjWR6Cg5mktwEO9TYpmh+mrpZ4jVXxCPk6aK
         fcwM/4Aus95RVmaJbLe17HdTr+vSy39ZAdWg+/7rU2f1CU87ABR8bGrKF6m0QPRurJp+
         wTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRboA2lJ2kIoc1yVrTeE0yKRXBLg8DrW4V7cxpnbj5w=;
        fh=oxHQc/qjpX1VQHfYnsvQciFn+VLJsDU65lOhNZRb33k=;
        b=qZKXaB4dITWA2pxGACnz8HWgJCdXhbBtfdHgPbOXzuZs9AbEyRnueAKFiAPHkfg13l
         FDNiTDu9z9cB3Kloole3jBP7YECadGwAW9AkUeAXIoalc47nsp3D5ekia9Lf07kuB6XD
         GGp3CNh+7ADOJnPFt+zFp5WgO9twFaPeFSU1FGB41Wp3WNDIYdzSQfwFy7B0r/dB8Fd4
         HHR0E3B/7QpsU+2WUQ/9UZfAJzby1cR294q2f8hugIWwiF/l8Q99zbAMwwyRMnr97YrO
         jsP8NoF4QvE9A4FRrC53WqDCStPvIAPU++5Rm36NRtqPMPcYoHym3BUmoD5zTEPVoqoR
         v5rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789150502; x=1789755302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yRboA2lJ2kIoc1yVrTeE0yKRXBLg8DrW4V7cxpnbj5w=;
        b=NyWNpt817nBZzAUEFKJbFRkfyTX2T6OfjjOF1hr+J9dpdOG9VTkH84QLSXnPfkKwwL
         qap0hOiWYxAdmluq6327JF+228ATOO3X1QOhuj8QJk9FlwlcfBuDxJ2etLB/UAZSaZ+H
         0S8nnVWXXirEBCy7ryFgYSd7Z+sYaR/wD/se1CyJ0vLjLbzijI2MEWLjvtcQzE+XPPu0
         Xtxaka9fQ7SVQqLwaM3xc0sVsqkcrJn0fVA2yKjLgSuyScpchalidRYcW5KDTng8X54Y
         xI0Mdx6CtacQ9t69jxeNhuqtKdd6mrOqeYzeGUfW5yu77+5d0t10CgiPkACB0TZyInWO
         AxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150502; x=1789755302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRboA2lJ2kIoc1yVrTeE0yKRXBLg8DrW4V7cxpnbj5w=;
        b=K+l3SdqEZkP5A43g4gQ5z0ar3hLu6Pskaec/E1Sns0ZoqWb6yE8jfsVzSAi+Ouuqqg
         nz/GRde+ixPOq+ffHJwb0KmV3dQKoHQIppHYKWXLxo9tTDMIE6y8W0y9uzFChI6ZSsRZ
         7Mp0j4S1fdxLk7Z9E0HRAnWqS4U+LK2Qkt0bRp51lHUS9vZUhzCnmQdkKpXuDjOG2gBP
         JtYeZAMmkA2RCSkzRo1oGNfLktLMaCvtD2b3eX6XhpbRujDiFg7nZfhLGf/pZj9f/Hj0
         142o3Q/G/MAMOt7HUr0MZMTPZtc6HK5PhKA75QDqHOIFWdy8Us1lgjLYKyV+W2imbBbi
         ZU4w==
X-Forwarded-Encrypted: i=1; AKwUvByyN43EVzW1lTHrBvWzqAagUtB+6k6BdmjO5FAtBm6vb4tbPh+sW02M17elC77PPucWvfxVTWL4a6Yoq2FlIYXps8b6VdQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kLHKevCFt67ZHV4JW0JV88eAk1cF0ii4GJenaAh/kCeMU2FP60
	oSL7zEt3I9jEC6W7D8H4gSp+ZNVLDtYz/17SfP0kXekFPSbGE6VHUMtpxz4EzjKVnbyT20Ygm8e
	qxvn7oe0DerOThLLA9xs0G3zQjUjGL6DrpmeaSAZk
X-Gm-Gg: AYBFou15NGaMoefJLpwZlba8vOjC8lT6o3JYM0hvXpHEGb8Uht8GM/o3BUI4XEo8Juu
	7vrh+GfdNGaZW38jA75NDH+zGc6icgK/X/isZvV68pHtLbhXZlykjbwdlpKZx7mMy/oxt80Fw02
	by/64Ouv5/RDshOh5c92iPpg0pYKCOIBaZ/vCu3vRLJ9g7BFACQ3SapZJox7+fqeoKXrr3KELfB
	qyUKvrqjXZ4T5TGNJe6G+FUSG13qyZtYCBxe5DnJclt57c19Zr7TI9oEVYAqoKriNUxRGptrGoI
	SHsJxjziVmiqAOSBzkAjUl7Dhs0JpI6vNZyd6Nk5aIhSoMqDFgMOso63ZyYt5Dmps0uKp4zBI6b
	tnHfTQ7oLdZo=
X-Received: by 2002:a17:90a:d64c:b0:396:d27b:89b9 with SMTP id
 98e67ed59e1d1-39d9bd6197bmr9465904a91.10.1789150502370; Fri, 11 Sep 2026
 11:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com> <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
In-Reply-To: <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Sep 2026 14:14:50 -0400
X-Gm-Features: AcwNN1XvZ2t1QpElaSJ_H9N8jEw7pF3zTUmE1E90vyMLzERl5dKL7VmQb1Vrt48
Message-ID: <CAHC9VhQPprfmHVwi1r+Ddvussdp8FW60A2Q7bXCfSYJ8n7PzPA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: verify mount idmaps reach inode hooks
To: daan@amutable.com
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

Merged into lsm/dev, thanks everyone!

--=20
paul-moore.com
