Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02675CDB474
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Oct 2023 03:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjJWDJk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 22 Oct 2023 23:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjJWDJj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 22 Oct 2023 23:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789FD76
        for <linux-security-module@vger.kernel.org>; Sun, 22 Oct 2023 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698030512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBOeibxJX7ajf1aeV2Zk4DcGw5kQ9lUUzX6LACViMuU=;
        b=NQ05nmD7ogDvke7SWIVTl85PwjG76iemrXfPUNdb6Ba3pdgvqOThHpq8XJE/2pP4+1Wliv
        2ErbBdNkOFwjSolgPUorT/3zLR11wJT0G0FKAGdXdZd01pRX5uFi1GURyVi7iJNnzxwCoB
        TB4ruB+GYJQ4nNBN7aJz4NZsyelAEIg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-LzWMNUmdOr2Wr9U8DTx3xQ-1; Sun, 22 Oct 2023 23:08:26 -0400
X-MC-Unique: LzWMNUmdOr2Wr9U8DTx3xQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507cc15323aso2667181e87.0
        for <linux-security-module@vger.kernel.org>; Sun, 22 Oct 2023 20:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698030504; x=1698635304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBOeibxJX7ajf1aeV2Zk4DcGw5kQ9lUUzX6LACViMuU=;
        b=ZnlK3eE1lbKar+8NCkllaECqImUmPgXlQ37NBvcJOjW52/Aqcj//mKUhzJWgu7/wLq
         1DoRh9RNeNkeOXNF1GZhioF5rhl0un5lsRRS9ykQBeSeVL3+KRppXKmkRtxYvvYl+bii
         piuWBft1jwvLm8DbuPq5ImaUDDMHsmJK3rIaQFt0ik/dMndyA/+ZQjM8ywY9TYdJjbbv
         IebDZ2HM2JJBQhJoKp8Kk2Mu0iHSY300IrRV2rEHQQCFeId7P6b5hWUXHc6SZT7NAiBb
         UZWI/m9uxtyGsPiAggnn88gso3OtfocT0OchTM8n+Cqhvhd9M+6agtanHDlN4LCgRmGi
         1ebg==
X-Gm-Message-State: AOJu0Yw92bSdU2cadspir+VT7xSRUwlBz7l6cD2yuuqRV909FC9kiyzK
        cDxg6qJ7QAiG2kmlug58QTkw2ftMy0lQjoKJzrMcEquLZ0Myx0YdJIg26gKCEe7pnRX/QNqw4IH
        AdqGvQ4j3LJ+g7n57iIgW+UR+ki3GIF6835SVRSq/p1rov84/qUhd
X-Received: by 2002:ac2:55bc:0:b0:503:5d8:da33 with SMTP id y28-20020ac255bc000000b0050305d8da33mr6046331lfg.20.1698030504585;
        Sun, 22 Oct 2023 20:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGwpB4vFIdAbZcfeljxER7LRweZf4ru9I2yvVHjzD+LCuTkM/A5Yje/fKSpyK+5d8M/rDIDjEYZ98BuZFgyR4=
X-Received: by 2002:ac2:55bc:0:b0:503:5d8:da33 with SMTP id
 y28-20020ac255bc000000b0050305d8da33mr6046327lfg.20.1698030504273; Sun, 22
 Oct 2023 20:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231020155819.24000-1-maxime.coquelin@redhat.com> <20231020155819.24000-4-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-4-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 23 Oct 2023 11:08:11 +0800
Message-ID: <CACGkMEsKvLTQNPp3JE9V4MBEuv5LVC+tRXgYYijgb9N0DNtGZw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] vduse: Temporarily disable control queue features
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     mst@redhat.com, xuanzhuo@linux.alibaba.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 20, 2023 at 11:58=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
>
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's disable control virtqueue and features that depend on
> it.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

I wonder if it's better to do this with patch 2 or before patch 2 to
unbreak the bisection?

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 73ad3b7efd8e..0243dee9cf0e 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -28,6 +28,7 @@
>  #include <uapi/linux/virtio_config.h>
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_blk.h>
> +#include <uapi/linux/virtio_ring.h>
>  #include <linux/mod_devicetable.h>
>
>  #include "iova_domain.h"
> @@ -46,6 +47,30 @@
>
>  #define IRQ_UNBOUND -1
>
> +#define VDUSE_NET_VALID_FEATURES_MASK           \
> +       (BIT_ULL(VIRTIO_NET_F_CSUM) |           \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |     \
> +        BIT_ULL(VIRTIO_NET_F_MTU) |            \
> +        BIT_ULL(VIRTIO_NET_F_MAC) |            \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |     \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |     \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |      \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_ECN) |       \
> +        BIT_ULL(VIRTIO_NET_F_HOST_UFO) |       \
> +        BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |      \
> +        BIT_ULL(VIRTIO_NET_F_STATUS) |         \
> +        BIT_ULL(VIRTIO_NET_F_HOST_USO) |       \
> +        BIT_ULL(VIRTIO_F_ANY_LAYOUT) |         \
> +        BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
> +        BIT_ULL(VIRTIO_RING_F_EVENT_IDX) |          \
> +        BIT_ULL(VIRTIO_F_VERSION_1) |          \
> +        BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |     \
> +        BIT_ULL(VIRTIO_F_RING_PACKED) |        \
> +        BIT_ULL(VIRTIO_F_IN_ORDER))
> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -1778,6 +1803,16 @@ static struct attribute *vduse_dev_attrs[] =3D {
>
>  ATTRIBUTE_GROUPS(vduse_dev);
>
> +static void vduse_dev_features_filter(struct vduse_dev_config *config)
> +{
> +       /*
> +        * Temporarily filter out virtio-net's control virtqueue and feat=
ures
> +        * that depend on it while CVQ is being made more robust for VDUS=
E.
> +        */
> +       if (config->device_id =3D=3D VIRTIO_ID_NET)
> +               config->features &=3D VDUSE_NET_VALID_FEATURES_MASK;
> +}
> +
>  static int vduse_create_dev(struct vduse_dev_config *config,
>                             void *config_buf, u64 api_version)
>  {
> @@ -1793,6 +1828,8 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         if (!dev)
>                 goto err;
>
> +       vduse_dev_features_filter(config);
> +
>         dev->api_version =3D api_version;
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
> --
> 2.41.0
>

