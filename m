Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35C8C433DB
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 06:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0F16146D
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Jan 2021 06:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhA1GKR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:10:17 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59746 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhA1GKD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Jan 2021 01:10:03 -0500
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 10S69GZX089344;
        Thu, 28 Jan 2021 15:09:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Thu, 28 Jan 2021 15:09:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 10S69FU5089275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Jan 2021 15:09:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com
References: <000000000000647eff05b3f7e0d4@google.com>
 <20201113120055.11748-1-hdanton@sina.com>
 <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <ea4028b7-53f2-aeaf-76e7-69874efcdec5@I-love.SAKURA.ne.jp>
Date:   Thu, 28 Jan 2021 15:09:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/11/14 2:14, Shuah Khan wrote:
> On 11/13/20 5:00 AM, Hillf Danton wrote:
>> Thu, 12 Nov 2020 23:21:26 -0800
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    9dbc1c03 Merge tag 'xfs-5.10-fixes-3' of git://git.kernel...
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10453034500000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=1735b7978b1c3721
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=95ce4b142579611ef0a9
>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>> userspace arch: i386
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
> 
> I would like to see the reproducer for this. I just can't reproduce
> this problem.
> 
>>
>> Fix 96c2737716d5 ("usbip: move usbip kernel code out of staging")
>> by closing the race between readers and writer of ud->tcp_socket on
>> sock shutdown. To do that, add waitqueue for usbip device and make
>> writer wait for all readers to go home before releasing the socket.

Worrysome part for me is vhci_device_reset() which resets ud->tcp_socket to NULL
without waiting for tx thread to terminate, though I don't know if
vhci_device_reset() can be called while tx thread is running.

I'd like to try below debug printk() patch on linx-next tree, for this bug is
reported on linux.git and linux-next.git trees. Which git tree can be used for
sending this to-be-removed patch to linux-next.git ? I wish there is a kernel
config for fuzzers in linux.git so that every git tree can carry debug printk()
patch for syzbot's reports...

Subject: [PATCH] usb: usbip: vhci_hcd: add printk() for debug

This is linux-next only patch for examining a bug reported at
https://syzkaller.appspot.com/bug?id=3e1d941a31361efc4ced2ba8b4af2044d4e43c59 .

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/usb/usbip/stub_dev.c   |  6 ++++++
 drivers/usb/usbip/vhci_hcd.c   | 11 +++++++++++
 drivers/usb/usbip/vhci_sysfs.c |  4 ++++
 drivers/usb/usbip/vhci_tx.c    | 12 ++++++++++++
 drivers/usb/usbip/vudc_dev.c   |  6 ++++++
 5 files changed, 39 insertions(+)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 2305d425e6c9..627f83c0ebc8 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -131,10 +131,14 @@ static void stub_shutdown_connection(struct usbip_device *ud)
 
 	/* 1. stop threads */
 	if (ud->tcp_rx) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+			pr_info("%s: stop rx %p\n", __func__, ud->tcp_rx);
 		kthread_stop_put(ud->tcp_rx);
 		ud->tcp_rx = NULL;
 	}
 	if (ud->tcp_tx) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+			pr_info("%s: stop tx %p\n", __func__, ud->tcp_tx);
 		kthread_stop_put(ud->tcp_tx);
 		ud->tcp_tx = NULL;
 	}
@@ -146,6 +150,8 @@ static void stub_shutdown_connection(struct usbip_device *ud)
 	 * not touch NULL socket.
 	 */
 	if (ud->tcp_socket) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+			pr_info("%s: close sock %p\n", __func__, ud->tcp_socket);
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
 		ud->sockfd = -1;
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 3209b5ddd30c..9e95bf9330f5 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1016,10 +1016,14 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 
 	/* kill threads related to this sdev */
 	if (vdev->ud.tcp_rx) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+			pr_info("%s: stop rx %p\n", __func__, vdev->ud.tcp_rx);
 		kthread_stop_put(vdev->ud.tcp_rx);
 		vdev->ud.tcp_rx = NULL;
 	}
 	if (vdev->ud.tcp_tx) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+			pr_info("%s: stop tx %p\n", __func__, vdev->ud.tcp_tx);
 		kthread_stop_put(vdev->ud.tcp_tx);
 		vdev->ud.tcp_tx = NULL;
 	}
@@ -1027,6 +1031,8 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 
 	/* active connection is closed */
 	if (vdev->ud.tcp_socket) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+			pr_info("%s: close sock %p\n", __func__, ud->tcp_socket);
 		sockfd_put(vdev->ud.tcp_socket);
 		vdev->ud.tcp_socket = NULL;
 		vdev->ud.sockfd = -1;
@@ -1074,6 +1080,11 @@ static void vhci_device_reset(struct usbip_device *ud)
 	vdev->udev = NULL;
 
 	if (ud->tcp_socket) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT)) {
+			pr_info("%s: close sock %p\n", __func__, ud->tcp_socket);
+			BUG_ON(vdev->ud.tcp_tx);
+			BUG_ON(vdev->ud.tcp_rx);
+		}
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
 		ud->sockfd = -1;
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index be37aec250c2..b37e7770aa35 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -390,6 +390,10 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 
 	vdev->ud.tcp_rx = kthread_get_run(vhci_rx_loop, &vdev->ud, "vhci_rx");
 	vdev->ud.tcp_tx = kthread_get_run(vhci_tx_loop, &vdev->ud, "vhci_tx");
+	if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT)) {
+		BUG_ON(IS_ERR(vdev->ud.tcp_rx));
+		BUG_ON(IS_ERR(vdev->ud.tcp_tx));
+	}
 
 	rh_port_connect(vdev, speed);
 
diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index 0ae40a13a9fe..05da652e7bbe 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -63,6 +63,9 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 	int iovnum;
 	int err = -ENOMEM;
 	int i;
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+	struct socket *socket = vdev->ud.tcp_socket;
+#endif
 
 	while ((priv = dequeue_from_priv_tx(vdev)) != NULL) {
 		int ret;
@@ -135,6 +138,11 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 			iovnum++;
 			txsize += len;
 		}
+#ifdef CONFIG_DEBUG_AID_FOR_SYZBOT
+		if (!socket || socket != vdev->ud.tcp_socket)
+			pr_err("%s: sock changed from %p to %p\n",
+			       __func__, socket, vdev->ud.tcp_socket);
+#endif
 
 		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, iovnum,
 				     txsize);
@@ -237,6 +245,8 @@ int vhci_tx_loop(void *data)
 	struct usbip_device *ud = data;
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
 
+	if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+		pr_info("%s: thread starting %p\n", __func__, vdev->ud.tcp_tx);
 	while (!kthread_should_stop()) {
 		if (vhci_send_cmd_submit(vdev) < 0)
 			break;
@@ -251,6 +261,8 @@ int vhci_tx_loop(void *data)
 
 		usbip_dbg_vhci_tx("pending urbs ?, now wake up\n");
 	}
+	if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+		pr_info("%s: thread exiting %p\n", __func__, vdev->ud.tcp_tx);
 
 	return 0;
 }
diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index c8eeabdd9b56..816cb4b5700b 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -437,15 +437,21 @@ static void vudc_shutdown(struct usbip_device *ud)
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 
 	if (ud->tcp_rx) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+			pr_info("%s: stop rx %p\n", __func__, ud->tcp_rx);
 		kthread_stop_put(ud->tcp_rx);
 		ud->tcp_rx = NULL;
 	}
 	if (ud->tcp_tx) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+			pr_info("%s: stop tx %p\n", __func__, ud->tcp_tx);
 		kthread_stop_put(ud->tcp_tx);
 		ud->tcp_tx = NULL;
 	}
 
 	if (ud->tcp_socket) {
+		if (IS_BUILTIN(CONFIG_DEBUG_AID_FOR_SYZBOT))
+			pr_info("%s: close sock %p\n", __func__, ud->tcp_socket);
 		sockfd_put(ud->tcp_socket);
 		ud->tcp_socket = NULL;
 	}
-- 
2.18.4
