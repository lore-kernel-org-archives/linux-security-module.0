Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91391EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jun 2023 14:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjFSOnX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFSOnW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 10:43:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AA0A0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 07:43:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so186550e87.3
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687185799; x=1689777799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jg4ozZVfolPqyn/t5WEFg1Uls/OOAkHpHShj9UmDbj0=;
        b=XM/YRcXn05iISSP7KE+IKbXpoTRTcJ718yU5TO6gcp/oHw+hYoh0ZSL4WhK5bcd+jf
         6mAAKvJM6L/16KW2cU/etYW1s4n/kP+ZnqPLRw8j4gkGd0gBhg1EckAqltFK62g5BFYv
         F4qZ8WHPYxeuBDUf/227tO1lNgF62oIqWUhWUrhBf9LFkoyFtowqLyVpxk38pWpTioks
         T7z7sbBXhgtHTmX23pNuwBDYalbF+BQqJh5pyC+/pn403N4z5DFsbO0q8GwU0+Gh0Tmo
         BacDMSvWblkXQmOTRpcEQLKJNp4qvOSKcG6e6P5B9YRsKldgvakXMH2eSJMQySdw+iGm
         LCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687185799; x=1689777799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg4ozZVfolPqyn/t5WEFg1Uls/OOAkHpHShj9UmDbj0=;
        b=I5EFEC3K5wZ/s2yadDOGY3GZ3OynMrcxwhhfryv8LkKTb9tyq79xpjiTWNntVRgyMk
         YefJ9DjWWSY4vrzLY8g+pffhqboxvJwYtwIB6ZlzM4m68AD37OUosApyzOS579ODArKg
         /7SXXKDGyDalVh/gGIpzipdcX+Emt0Wb34Je1pERI9NcY+uTLwYUp9co5zz0bwVpOs2j
         bKvL3YrX/4DMGXcEsfjFkQA3UMi3uYySm3Q7hAhkl2h+k9P7q9gXd6XFXrbtXhuwvqQl
         Jsqa1JgslJbjn89L9aBasPFCJKGFwIVp7jGouqeHYJq9vrOUo9Wc1aUI8K35LqBuSGMa
         hejA==
X-Gm-Message-State: AC+VfDwW5/8spAhocTUwE6y1XBx4Ax0OUuvI+otrCgBYUFchSn7aZl85
        JAXI95cjFb0ARHZ9JspvMsvyL2SJlK/kYSaftf+ZUQ==
X-Google-Smtp-Source: ACHHUZ6jK/vkslU8B7BumS0VEdj9EzsfjsiTwLT42WV7OsJvLgsBm6xMwCmMKVvxkyum5HDdV4pj/Q==
X-Received: by 2002:a19:da01:0:b0:4f8:3b15:b878 with SMTP id r1-20020a19da01000000b004f83b15b878mr4868043lfg.67.1687185799177;
        Mon, 19 Jun 2023 07:43:19 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k6-20020adfd846000000b003111025ec67sm13972121wrl.25.2023.06.19.07.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 07:43:18 -0700 (PDT)
Date:   Mon, 19 Jun 2023 16:43:17 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Paul Moore <paul@paul-moore.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH net-next] netlabel: Reorder fields in 'struct
 netlbl_domaddr6_map'
Message-ID: <ZJBphdB/7k0Hk8y2@nanopsycho>
References: <aa109847260e51e174c823b6d1441f75be370f01.1687083361.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa109847260e51e174c823b6d1441f75be370f01.1687083361.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Sun, Jun 18, 2023 at 12:16:41PM CEST, christophe.jaillet@wanadoo.fr wrote:
>Group some variables based on their sizes to reduce hole and avoid padding.
>On x86_64, this shrinks the size of 'struct netlbl_domaddr6_map'
>from 72 to 64 bytes.
>
>It saves a few bytes of memory and is more cache-line friendly.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
