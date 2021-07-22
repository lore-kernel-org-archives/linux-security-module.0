Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C22C63797
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Jul 2021 09:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4141F6121E
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Jul 2021 09:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhGVI5s (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhGVI5r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Jul 2021 04:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626946702;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GMDhEk1OkLprNSPz8zjEiaW53yrfQRSNmsbJ+lXjzZg=;
        b=EpTBW7p4s+YxXaOeARdCknw+hqAIuW/qrVtJnODyBi+lOS+0IGvChjecpvpkqWo71DgefT
        tFX1N/Q4CwWMmYewhDiQd+DngtLZANKr7tjQKMs5kElEmhRpcE1QFOJUM/Yk6JCBP+2kXv
        D8fvUZwo9fvP+8W1xme3awdL6J/qR/I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-krCiHcmLNCKrFqFyp1UzEQ-1; Thu, 22 Jul 2021 05:38:19 -0400
X-MC-Unique: krCiHcmLNCKrFqFyp1UzEQ-1
Received: by mail-qv1-f72.google.com with SMTP id eo14-20020ad4594e0000b02902fc3fd31414so3338746qvb.16
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jul 2021 02:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=GMDhEk1OkLprNSPz8zjEiaW53yrfQRSNmsbJ+lXjzZg=;
        b=Hu09UZ6vxFr+sCjI89/UEIJLMFtkGNcHZNZ6GVGSVzKffEpKvVfbQEqm9J2yrySR6A
         LXBJ+imb6+1Sd9uLl7bfN4OL986F4AIX7pwv9uZOYCzjKf9uLltkl3e1cKwSLw53/Coe
         hvDPpwxt+PU1VHgjRI8V995rf0tF6jdIQqzpMahdqaJuUwpJyltXx71RJvK6hdPEOnAj
         mNvFU4g25C3bRFftgge+a6IQiD65DybK5jWuMFvnjtcXdiQcBo7+NR5aH/sg83rhWX2a
         zIolPptzQsbNHYXLUSusbYrRABZHiJwbAjTlOorFD3PJRlGJD4figw4L3FnOvr+6Xh9u
         AYsQ==
X-Gm-Message-State: AOAM5301ih1bxzKmF9TD79sWJjiH73KEb9QTc6WV3sEKmvRu0DCdepLF
        00UUJEHjZus+/fveXFWeYOiUo9qTVakZBub/XwXXGtvCot0dUYy8E/tGPj8vumaXM0zJEmy/toc
        CK6OR9jABviYsCESwkG5/AOa8wp03rS3BEP7z
X-Received: by 2002:ac8:6698:: with SMTP id d24mr34653527qtp.37.1626946699129;
        Thu, 22 Jul 2021 02:38:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4XuNtfXEcjS3ssrkbA2cLFnm0IQF4VZ1dNSqxRKQE0ePuShqVer3ONZGYjuFRL1sQ7USpGQ==
X-Received: by 2002:ac8:6698:: with SMTP id d24mr34653514qtp.37.1626946698933;
        Thu, 22 Jul 2021 02:38:18 -0700 (PDT)
Received: from localhost.localdomain (cpe-74-65-150-180.maine.res.rr.com. [74.65.150.180])
        by smtp.gmail.com with ESMTPSA id v25sm7323738qkf.108.2021.07.22.02.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 02:38:18 -0700 (PDT)
Reply-To: dwalsh@redhat.com
Subject: Re: AVC denied for docker while trying to set labels for tmpfs mounts
To:     Sujithra P <sujithrap@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <CAP198X8TNTv1tqpO6Y7eyE2+iSwK9XHk0qRH6J-Z0Ww=a+53tA@mail.gmail.com>
 <CAHC9VhSBo1CHCM+k5TocQS7--+bGL5RY0z6WKKunE76-fuR6iw@mail.gmail.com>
 <CAP198X-7NZ+1QfYK3cUUkMMNoaJTwNzBN8wr27egWT1kVh=g3Q@mail.gmail.com>
From:   Daniel Walsh <dwalsh@redhat.com>
Organization: Red Hat
Message-ID: <c22dcebb-e766-d1e2-1e15-15a85e2124bb@redhat.com>
Date:   Thu, 22 Jul 2021 05:38:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAP198X-7NZ+1QfYK3cUUkMMNoaJTwNzBN8wr27egWT1kVh=g3Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dwalsh@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/21/21 18:17, Sujithra P wrote:
> Thanks Paul!
>
> Is there any specific centos/RH mailing list that I can ask? Not sure
> whether it is a problem with kernel/docker/kubelet.
> semodule -R seems to fix the problem, but not sure what is causing the
> loaded policy to get corrupt.
> Any insight on how to figure this out would be very much appreciated.
>
> Thanks
> Sujithra.
I am guessing that one of the containers is loading policy.  You should 
be able to see something in the auditlog, about a policy load.
> On Wed, Jul 21, 2021 at 2:01 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Jul 21, 2021 at 2:46 PM Sujithra P <sujithrap@gmail.com> wrote:
>>> Hi SELinux Experts,
>>>
>>> The following issue is described in the below post as well.
>>> https://github.com/containers/container-selinux/issues/141
>>>
>>> Occasionally running into the following selinux denials for docker
>>>
>>> type=AVC msg=audit(1626732057.636:4583): avc:  denied  { associate }
>>> for  pid=57450 comm="dockerd" name="/" dev="tmpfs" ino=150014
>>> scontext=system_u:object_r:container_file_t:s0:c263,c914
>>> tcontext=system_u:object_r:lib_t:s0 tclass=filesystem permissive=0
>>>
>>> type=AVC msg=audit(1626812823.170:9434): avc:  denied  { associate }
>>> for  pid=20027 comm="dockerd" name="/" dev="tmpfs" ino=198147
>>> scontext=system_u:object_r:container_file_t:s0:c578,c672
>>> tcontext=system_u:object_r:locale_t:s0 tclass=filesystem permissive=0
>>>
>>>
>>>   level=error msg="Handler for POST
>>> /v1.40/containers/a3a875e7896384e3bff53b8317e91ed4301a13957f42187eb227f28e09bd877c/start
>>> returned error: error setting label on mount source
>>> '/var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret':
>>> failed to set file label on
>>> /var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret:
>>> permission denied"
>>>
>>>
>>> Docker is not able to set labels for these tmpfs mounts because they
>>> end up having wrong labels when they are created (sometimes
>>> "locale_t", sometimes "lib_t" which of course is not the
>>> default/correct context for tmpfs fs).
>>> Apparently semodule -R and deleting these tmps files or reboot of the
>>> node fixes the problem.
>>> Not sure what is causing the tmpfs mounts to get wrong labels in the
>>> first place.
>>>
>>> Everything seems to be fine to begin with, but as the system keeps
>>> scheduling pods on the node, this behavior is observed sometimes (not
>>> consistent always).
>>>
>>>
>>> OS Details:
>>>
>>> NAME="CentOS Linux"
>>> VERSION="8 (Core)"
>>> ID="centos"
>>> ID_LIKE="rhel fedora"
>>> VERSION_ID="8"
>>> PLATFORM_ID="platform:el8"
>>> PRETTY_NAME="CentOS Linux 8 (Core)"
>>>
>>> Docker Version:
>>> Client: Docker Engine - Community
>>> Version: 19.03.13
>>> API version: 1.40
>>> Go version: go1.13.15
>>> Git commit: 4484c46d9d
>>> Built: Wed Sep 16 17:02:36 2020
>>> OS/Arch: linux/amd64
>>> Experimental: false
>>>
>>> Kubernetes Version*
>>> v1.20.8-gke.1500
>>>
>>>
>>> Any help on how to debug this issue  would be greatly appreciated.
>> This sounds like it might be a problem with CentOS and/or your Docker
>> install, have you tried talking with the RH/CentOS folks about this
>> problem?  We focus mostly on upstream issues here and it isn't clear
>> to me at this moment that this is an upstream issue.
>>
>> --
>> paul moore
>> www.paul-moore.com


