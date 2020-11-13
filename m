Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B6C55ABD
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 17:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A65822226
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 17:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SfXCVk3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKMROe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgKMROe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Nov 2020 12:14:34 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B88C0613D1
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2020 09:14:48 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y17so9127817ilg.4
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2020 09:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WEvraIZkF0cWOj/dfivLnLiDfbUaBgrjDgBa9dn7IYk=;
        b=SfXCVk3jKMkxT+wb9NCADz20uvpExJKoj6ofbvkk/mytQFIHyIWzKOFS0lucSZm6CA
         8rwqErJY0FqKiZpT3Wgg3zB5rc2Mm/0iw6MC3LdpfHHjj5uguVDFYkZKr2JlV6aF1LuY
         rZ3MXYq4+8Z6AnYlX1OAfwz0WXqatoOVSTaJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WEvraIZkF0cWOj/dfivLnLiDfbUaBgrjDgBa9dn7IYk=;
        b=oW7OMedYqscHfC04sDeC3hxsleNvtRJ1ilHvJ6FtFNPHkOMycQYfhgPWG7fHBNzq2c
         ORJeFcvbCdOkmVIQU1x2h73PvzGP10J+vy55+l9/E1mPHflwVyqDclxp7sEAcbhvvxZE
         ao3dck8B5a1bLnw25LoVJQDh+hNnjzFkPufCMzxT2hXTPc0e6H2MHvGJo0VP55ZKlm5Y
         dtCKoyaA0tEMecyU76QKKVp6eTOHsnldWx3dS0f87t+oRbAIjYaHMwdWsoMQAPWOSUIA
         wwW+lI2q8CAMXkZiCvR5AmKeqKY2mn6MzH8aEUOV/OKdzEOv7yDdtgsMsczPfiIPfjEk
         cV3A==
X-Gm-Message-State: AOAM533UPnx000Qb8KEz4gB3fxTtyuav/nAhzmRQAfyQUnHir4NYtsTS
        5exvtCtv+8K93s7rdlu4DC04zQ==
X-Google-Smtp-Source: ABdhPJxDT7vfdyRlarefZA6g1kBc2REinV4S7PQFYhdEY1lMsffksjEMeLrdGhhweOqG6KwPjm31qg==
X-Received: by 2002:a92:a008:: with SMTP id e8mr651660ili.83.1605287682461;
        Fri, 13 Nov 2020 09:14:42 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k16sm4659185ioc.1.2020.11.13.09.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 09:14:41 -0800 (PST)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <000000000000647eff05b3f7e0d4@google.com>
 <20201113120055.11748-1-hdanton@sina.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
Date:   Fri, 13 Nov 2020 10:14:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201113120055.11748-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/13/20 5:00 AM, Hillf Danton wrote:
> Thu, 12 Nov 2020 23:21:26 -0800
>> syzbot found the following issue on:
>>
>> HEAD commit:    9dbc1c03 Merge tag 'xfs-5.10-fixes-3' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10453034500000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=1735b7978b1c3721
>> dashboard link: https://syzkaller.appspot.com/bug?extid=95ce4b142579611ef0a9
>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>> userspace arch: i386
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>

I would like to see the reproducer for this. I just can't reproduce
this problem.

> 
> Fix 96c2737716d5 ("usbip: move usbip kernel code out of staging")
> by closing the race between readers and writer of ud->tcp_socket on
> sock shutdown. To do that, add waitqueue for usbip device and make
> writer wait for all readers to go home before releasing the socket.
> 
> 
> --- a/drivers/usb/usbip/usbip_common.h
> +++ b/drivers/usb/usbip/usbip_common.h
> @@ -277,6 +277,9 @@ struct usbip_device {
>   		void (*reset)(struct usbip_device *);
>   		void (*unusable)(struct usbip_device *);
>   	} eh_ops;
> +
> +	atomic_t sk_shutdown_count;
> +	wait_queue_head_t sk_shutdown_waitq;
>   };
>   
>   #define kthread_get_run(threadfn, data, namefmt, ...)			   \
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -1008,15 +1008,20 @@ static void vhci_shutdown_connection(str
>   
>   	/* kill threads related to this sdev */
>   	if (vdev->ud.tcp_rx) {
> +		atomic_inc(&ud->sk_shutdown_count);
>   		kthread_stop_put(vdev->ud.tcp_rx);
>   		vdev->ud.tcp_rx = NULL;
>   	}
>   	if (vdev->ud.tcp_tx) {
> +		atomic_inc(&ud->sk_shutdown_count);
>   		kthread_stop_put(vdev->ud.tcp_tx);
>   		vdev->ud.tcp_tx = NULL;
>   	}
>   	pr_info("stop threads\n");
>   
> +	wait_event(ud->sk_shutdown_waitq,
> +			!atomic_read(&ud->sk_shutdown_count));
> +
>   	/* active connection is closed */
>   	if (vdev->ud.tcp_socket) {
>   		sockfd_put(vdev->ud.tcp_socket);
> @@ -1104,6 +1109,8 @@ static void vhci_device_init(struct vhci
>   	vdev->ud.eh_ops.reset = vhci_device_reset;
>   	vdev->ud.eh_ops.unusable = vhci_device_unusable;
>   
> +	init_waitqueue_head(&vdev->ud.sk_shutdown_waitq);
> +
>   	usbip_start_eh(&vdev->ud);
>   }
>   
> --- a/drivers/usb/usbip/vhci_rx.c
> +++ b/drivers/usb/usbip/vhci_rx.c
> @@ -264,5 +264,8 @@ int vhci_rx_loop(void *data)
>   		vhci_rx_pdu(ud);
>   	}
>   
> +	if (atomic_dec_and_test(&ud->sk_shutdown_count))
> +		wake_up(&ud->sk_shutdown_waitq);
> +
>   	return 0;
>   }
> --- a/drivers/usb/usbip/vhci_tx.c
> +++ b/drivers/usb/usbip/vhci_tx.c
> @@ -252,5 +252,8 @@ int vhci_tx_loop(void *data)
>   		usbip_dbg_vhci_tx("pending urbs ?, now wake up\n");
>   	}
>   
> +	if (atomic_dec_and_test(&ud->sk_shutdown_count))
> +		wake_up(&ud->sk_shutdown_waitq);
> +
>   	return 0;
>   }
> 


Without a reproducer, it is hard to verify the fix.

thanks,
-- Shuah
