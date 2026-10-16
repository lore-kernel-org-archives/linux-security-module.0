Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4D2253B0
	for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116484; cv=pass; b=B0LxXvhATq8T2eZb83h6x9kPH0QZTOy+/UNRb962MhfH/RiRznyCK1599HMu/u7Ged6lXbx7NeFT1IY6uj62xjBkm2Oq5ogily5borpGXFDLP4rCmnwuq2OXqblV1oql85TSvsd8xBlx2OALWp8SmJNPKoba36EQLf397mU+lWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116484; c=relaxed/simple;
	bh=c1JekfdBO66GzW1rX/7zumfUDS7si1cbVflnG96ZLWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdjymDtgLgeO/03e/WcKBeWUSKpOVBRPFy3PvEoZvE7LH3ts2SH0Cdm3AkXf1P0E7BAZ2l6jvmOqkFnE/NxyC6kh4y7VJi5zSoxISL1qb5d/57Eb5d4eyXfqdGlU0guC/Jluee+rMQCMGmGnJeysQweslKu/rpeShAPtoEdjct4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YD0ov2ZE; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YD0ov2ZE"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-85377c8bc96so2731853b3a.3
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2026 19:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792116482; cv=none;
        d=google.com; s=arc-20260327;
        b=KuiiNSwb7XYR/j0055nTSyLruM3gImk7HUMOohY9MWOalvbIxAPAH0iPstPWFIlx4V
         HM0WUw9KoZeMvNTJhQkFO9Zwcj5JUVDS1/HrPFgK0RQDORhufMDbeT//uyNJeE6psRMd
         V3Kt9C7c6v++oqu/OFDJM82/Sktwdsxs366c8CbkfRXJiLpdVUXuQgX0pz5t0HDngvf2
         hFXWcgYN7X7yAc4+whMXBNUNUrjKKtBk1L93eoyPpEvmws1EalxhdoVMNz7CRyxSSoBj
         ZMfwfFtHMSieJwohDk6cXFQW+Al7tTakFMsEVOwqnIyWauZVESi0M8MXrpj080ItxuEP
         WFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bfCTw59gEzccPxPGXarkXIf1k8IEGa1ctcGkrwNA/P8=;
        fh=KDOylUZJjbwKtqk8CoIqwlN+jeq41/h1vDfNGl3Rc10=;
        b=Ek1KzMRVoQGkPuzjKSM7zmDwJ/bmQEr6wwbg6hFPDhtXBHOEfe9x9pA9TSZpE5HORo
         Y+hqOB4wwEz9VId68dAnMOEO6+GtdaPuYOGldGzaA29FKWxLdKerDab/VMJlXJ4mTebM
         Zn9huJEYnykRVpGKl9YeNQdkyXT+c5E/ih/y/M20Qz+Sa5nLI4DVlzKqhI30P9hTYVFU
         jvFiLZzDOnSQBZa8TAviwQ6/0jIZlUwHPY695LUsiRl3cWMFoYTg634OdBZpTPRWt7rw
         mN6Zf2NOXNw84RdlW1D5JPiyIr4LYoH2T2M///YnsNliWFHzMZlXTCV1V0mgm1W2INPW
         ae1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792116482; x=1792721282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfCTw59gEzccPxPGXarkXIf1k8IEGa1ctcGkrwNA/P8=;
        b=YD0ov2ZEy/XnJwKAu33RhFEk6f1ZWj5i9Eua2hl/2tj28Ramb0PQXsZE91TZE1koFZ
         Zm0ylJytTFIw/r2hJyi2kqutcQJRKPN3Z4/PipZriaP2EUCCcMbRR9TQvS0jZeWAr5P5
         BW+iYhoN23vYR1BH+74ZWVZJGikzv+3QXBAjfs5DU1bx5/ahwiRjT7Rt15GZ/MxYFakW
         hDWTUkic3HQ2v+97dEweDmom/Whcg7DZlnhHTCHQTPZg+IXXEoKrmSFSPi+NPP7rfAES
         VQpz8Czt8JszpyOb7b3knvi9vh7ESq1HVmU2zA6CRnmWMpN095C33kXmhkk4+xWMA80f
         ItkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116482; x=1792721282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfCTw59gEzccPxPGXarkXIf1k8IEGa1ctcGkrwNA/P8=;
        b=qHWTKI22Uzy7KhIMr0i74ukffPVF0qp0pN46mK9yb/XfnYN/Di/FQJcBy0U+pe+pg8
         rTd/VS6hUo0j2XVXv1OW5nQ35WcSkhB7mB+pjS0mtCKyk8XRrSpR6Pv+E0h7YuVk3IuS
         nbC5SN0LyVlTfaeuXlU0LlpAxnoAAaTlP+XoqNY1CBda65kMFsjk0niQ72gJo8ngZhnr
         HGbAVv1ebdcALU4rWeJ79YHM7RR3+Sy0CmjrExerbYhk7XcSYxcSRFjvXd8MG0bdCMfd
         pDpqgK8PyHY9JHmGxutDqjyAPVlF9GdSQWKctE55C+/4CNLguKNk7TONkGea45f2qYwM
         0Lng==
X-Forwarded-Encrypted: i=1; AKwUvBzTFK29JhBZA7TMKovd5wM141mzwAUXbgS1UNsr05M01e3mPIX0miRwki4Vxoc910KsXkl72ug33b6lgJbvuMNxoY36c48=@vger.kernel.org
X-Gm-Message-State: AFq9FYLX1t7IEdu9xgeoO2L8RpAsyXfXZV/WHe7+iOmSnPtX2mWEFr6Y
	aJNEuIBgUOoU6zitO9kkMgJ4/hV6ykoCUdswkdgTAeplN0B7ytu69+1pF5/zmRUcz3qjeUCc/Vj
	MCxr6CGC3aXW4Jsf3okTvl7jUTfFQ0JvqSXxzP3qQ
X-Gm-Gg: AYBFou0McGP++WUtcGQT8lKyj3OSGukKCgqeRsM3f2VnU9VChWZLEfnjuRmNCbwW4qf
	OJQKvO1Xd+L/30s4WG90lH3DjFZIYspw9B5MbMj5o0RuqCK9r5XbTkMhGpX95F5WsOFgVow25gQ
	668jjiTTP7AzH7cH9iJKWzI9NNVqMtCrfzjgPh/ZUIHCIQ/uIDZH+VAv5sNtgR+Te1h7p9DHdiQ
	gZK8FYYqegCppnx4V5gFG05W2ch3KVF6Pki7ppDobDnyXTzJojSBk8Q+X4FYCdA5WnnlJHLKzY3
	VkwLyfV97yWhgFZBXWg67r9lomxnPERmh+HgUYvcvsPt6bhouL2sZIxdVke4eWe8o2T3pu4x+Rw
	YYVHI/LdeyB8=
X-Received: by 2002:a05:6a00:4287:b0:89e:779b:d03 with SMTP id
 d2e1a72fcca58-89e779b0f37mr2948665b3a.6.1792116482474; Thu, 15 Oct 2026
 19:08:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <179147329205.58079.5847298721173675285@gmail.com>
 <sashiko-outbox-165773@kernel.org> <CAHC9VhS+bdL_YnLQtd0sPmKKfy9BvS-LWV_6EhAuu4qfUFe_mw@mail.gmail.com>
 <852c9fb6-6217-440a-968c-b5ab3e22dbc8@redhat.com> <179210606199.96599.8994346249690707193@gmail.com>
In-Reply-To: <179210606199.96599.8994346249690707193@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Oct 2026 22:07:50 -0400
X-Gm-Features: AclHuK_xuEKifY20RXuv-jJv4fuayR2c_VgSKs7l2mBdBaAmWeWlt_XO4W1aGGY
Message-ID: <CAHC9VhRbdWFJapUxbOs68+1Mq_BtMqznw+hF_+zFwbOr=_becg@mail.gmail.com>
Subject: Re: [PATCH net v2] calipso: update payload_len when removing the
 CALIPSO option
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, sashiko-reviews@lists.linux.dev, 
	linux-security-module@vger.kernel.org, network dev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:14=E2=80=AFPM Joas Antonio dos Santos
<joasantonio108@gmail.com> wrote:
>
> On Thu, 15 Oct 2026, Paolo Abeni wrote:
> > The above looks like a pre-existing issue, the patch itself looks
> > correct, right?
>
> Hi Paolo, Paul,
>
> Yes, the issue is pre-existing; the delattr patch doesn't change it.
> The skb_pull()/memmove()/skb_reset_network_header() sequence quoted
> by Sashiko predates this patch, which only adjusts payload_len after
> it.
>
> I tested Paul's idea on top of both CALIPSO patches (QEMU, veth +
> br0 with bridge-nf-call-ip6tables=3D1, SELinux + NetLabel CALIPSO
> DOI 16):
>
> - without it, a bridged CALIPSO packet towards an unlabeled
>   destination reaches the peer with a corrupted Ethernet header
>   (garbage dst MAC, ethertype 0x0000) and is dropped; an unlabeled
>   packet towards a CALIPSO-mapped destination never reaches the peer.
> - with the nf_bridge_info_exists() check in selinux_ip_forward()
>   (plus a stub returning false for CONFIG_BRIDGE_NETFILTER=3Dn),
>   5/5 packets are delivered unmodified in both cases.
> - the routed path is unchanged: delattr 5/5, setattr still adds the
>   option 5/5. W=3D1 is clean with BRIDGE_NETFILTER=3Dy and =3Dn.
>
> Paul, if you like I can send it as a separate selinux patch with your
> Suggested-by.

Yes, please do.  Thanks for working on this!

--=20
paul-moore.com
