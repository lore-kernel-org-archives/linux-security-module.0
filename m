Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F4C61DA4
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Feb 2023 11:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBIL6w (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Feb 2023 06:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBIL4u (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Feb 2023 06:56:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB77683
        for <linux-security-module@vger.kernel.org>; Thu,  9 Feb 2023 03:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82CE9B82100
        for <linux-security-module@vger.kernel.org>; Thu,  9 Feb 2023 11:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987C2C433EF;
        Thu,  9 Feb 2023 11:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675943246;
        bh=KcEP21+pF4KwMmglSmsSBGTbmJs+n+Qw0DzK8I7J0jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xtwTiTCyY1FlnXEw9OfTCRgYMQDFAYLGJqRVc+g3CV7m6lL271KmivOHbqNMFIzpF
         izRKPxk+Cgoj5jGMK229ogKAX9dU5YkxgEUcmANY3INEsz+KlZLAG5LRC76Y60QFC0
         /6aAenv4WGxeXJ56Pxk8O4RjRw8CXfWm5wifDsZc=
Date:   Thu, 9 Feb 2023 12:47:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/14] Add TSEM specific documentation.
Message-ID: <Y+TdSivplpimof7o@kroah.com>
References: <20230204050954.11583-1-greg@enjellic.com>
 <20230204050954.11583-3-greg@enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204050954.11583-3-greg@enjellic.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 03, 2023 at 11:09:42PM -0600, Dr. Greg wrote:
> An entry was added to the ABI testing documentation to document
> the files in the TSEM management filesystem.
> 
> The file documenting the kernel command-line parameters was
> updated to document the tsem_mode command-line parameter.
> 
> The primary TSEM documentation file was added to the LSM
> administration guide and the file was linked to the index of LSM
> documentation.
> 
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  Documentation/ABI/testing/tsemfs              |  576 ++++++++

Ah, here's the documentation, thanks.

>  Documentation/admin-guide/LSM/index.rst       |    1 +
>  Documentation/admin-guide/LSM/tsem.rst        | 1240 +++++++++++++++++
>  .../admin-guide/kernel-parameters.txt         |    5 +
>  4 files changed, 1822 insertions(+)
>  create mode 100644 Documentation/ABI/testing/tsemfs
>  create mode 100644 Documentation/admin-guide/LSM/tsem.rst
> 
> diff --git a/Documentation/ABI/testing/tsemfs b/Documentation/ABI/testing/tsemfs
> new file mode 100644
> index 000000000000..3d326934624c
> --- /dev/null
> +++ b/Documentation/ABI/testing/tsemfs
> @@ -0,0 +1,576 @@
> +What:		/sys/fs/tsem
> +Date:		November 2022

It's not November 2022 anymore :(

thanks,

greg k-h
