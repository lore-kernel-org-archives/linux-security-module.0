Return-Path: <SRS0=DaHd=S3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA881C43219
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Apr 2019 19:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0269D2064A
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Apr 2019 19:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfDYTWT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:22:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50330 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfDYTWS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Apr 2019 15:22:18 -0400
Received: from static-50-53-47-167.bvtn.or.frontiernet.net ([50.53.47.167] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hJjwk-00026C-Iu; Thu, 25 Apr 2019 19:22:14 +0000
Subject: Re: smack ( on host ) + apparmor ( on docker ) - possible ?
To:     Casey Schaufler <casey@schaufler-ca.com>,
        shrawan kumar <connect.shrawan@gmail.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        smack-discuss-owner@lists.01.org
Cc:     Linux Security Module list <linux-security-module@vger.kernel.org>
References: <CALuYEFrJfWAqr=po=ELqvMsFftxpoO0QHA5_CJgd5e2p0h0euw@mail.gmail.com>
 <8234adc6-18c6-feab-ca04-d4cfbc64373f@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <9b180312-7244-ab97-2911-591470701a70@canonical.com>
Date:   Thu, 25 Apr 2019 12:22:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8234adc6-18c6-feab-ca04-d4cfbc64373f@schaufler-ca.com>
Content-Type: multipart/mixed;
 boundary="------------F255C21D91D810D00E37E9FC"
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This is a multi-part message in MIME format.
--------------F255C21D91D810D00E37E9FC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 4/25/19 8:52 AM, Casey Schaufler wrote:
> On 4/24/2019 9:37 PM, shrawan kumar wrote:
>> Dear Casey ,
>>
>> For one of my embedded project ,?? the requirement is to run a set of process under *Docker* and each process inside Docker needs to be sandboxed using *AppArmour*. However, the host from where Docker is launched is *Smack* enabled . We are using *smack* as default security on host .
>>
>> Is the above combination possible ?
> 
> With the current upstream kernel, no. You can't run more
> than one "major" security module at a time. As of 5.1 you
> will have more flexibility, but still not enough for Smack
> and AppArmor to coexist. Development is underway for the
> next phase of module stacking, which will be proposed for
> 5.3 and can be found:
> 
> git://github.com/cschaufler/lsm-stacking.git#stack-5.1-rc2-apparmor
> 
> With this patch set you can run Smack and AppArmor together.
> What I don't know is how you would configure AppArmor so that
> you can sub-configure your containers. I've added John Johansen
> to the thread. He is the AppArmor expert who has been working
> on AppArmor namespaces.
> 
> To the best of my knowledge no one has done what you want,
> but supporting your configuration is an explicit goal. We
> would be more than happy to help you in your efforts.
> 

As Casey says not possible with the current upstream kernel.
You do have a few options currently.

You can use the patchset Casey pointed you at or you can
cherry-pick a reduced size stacking variant from the Ubuntu 18.04
or 19.04 kernels. The patchsets are quite different but they are
effectively equivalent. They cutout patches that are not needed
to stack smack/selinux with apparmor.


Once you have a kernel that supports the stacking patchset. The
setup is fairly easy.

You need to boot with both smack and apparmor enabled. Under the
current LSM stacking and 19.04 kernels your kernel parameter is

lsm="yama,loadpin,safesetid,integrity,smack,apparmor"

or config

CONFIG_LSM="yama,loadpin,safesetid,integrity,smack,apparmor"


and the 18.04 version

security=smack,apparmor

there is a config option as well, but I don't remember it off the
top of my head.


Once you have this you can achieve what you want. You don't need
apparmor policy on the host, and you might not even need an
apparmor userspace, as long as each docker container has its own
apparmor userspace and policy.


For each container you are going to do three things.
0. Make sure securityfs is mounted (default location would be
   /sys/kernel/security/)
1. Create an apparmor namespace
2. Switch the display LSM (this does not exist in current upstream
LSM stacking, but hopefully 5.3)
3. Put the root container task into the apparmor namespace.

there is flexibility in the ordering but if you stick to the above
ordering you avoid some of the potential problems.

1. Creating an apparmor namespace.

AppArmor actually provides two ways for this to happen. Through its
fs interface, and through policy. I am going to assume you want to
skip policy on the host.

if your task is unconfined by apparmor (it will be if you don't
have policy on the host) and it has cap mac_admin (root). Then
you can do

  mkdir /sys/kernel/security/apparmor/policy/namespaces/$(NS_NAME)

where $(NS_NAME) is basically limited to alphanum with the first
character being alpha. And unfortunately there is no way to auto
reap apparmor policy namespaces so when your container dies.

  rmdir /sys/kernel/security/apparmor/policy/namespaces/$(NS_NAME)


2. Switch the display LSM, you basically have to write
  "apparmor" to /proc/current/attr/display

   I've attached a basic utility program (lsm-exec), I use to do this.
   You can rip the code you need from it. Basic usage is

   lsm-exec -l apparmor -- bash

   where bash can be replaced with any executable

3. Put the root task into the apparmor namespace. You can either
   use aa-exec from the apparmor userspace project
   https://gitlab.com/apparmor/apparmor/blob/master/binutils/aa_exec.c

   with basic usage of
   aa-exec -p ":$(NS_NAME):unconfined" -- bash

   where again you can replace bash

   Alternately you can skip aa-exec by writing

      "exec :$(NS_NAME):unconfined" to /proc/self/attr/exec

   The profile transition to the new namespace will happen at the next
   exec and that task and its children will inherit confinement in
   the policy namespace.

The task is now in you apparmor policy namespace, and assuming it
has cap mac_admin can load the containers policy.

I should note apparmor audit messages go to the audit subsystem which
currently isn't namespaced.

It is possible to have the host load the policy to the namespace for
the container if that is what you are looking for. And it is also
possible to have apparmor policy on the host along with smack if you
need to do that and some other interesting combinations, but I won't
bore you with details unless you ask.



--------------F255C21D91D810D00E37E9FC
Content-Type: text/x-csrc;
 name="lsm_exec.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lsm_exec.c"

/*
 *   Copyright (c) 2015
 *   Canonical, Ltd. (All rights reserved)
 *
 *   This program is free software; you can redistribute it and/or
 *   modify it under the terms of version 2 of the GNU General Public
 *   License published by the Free Software Foundation.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, contact Novell, Inc. or Canonical
 *   Ltd.
 */

#include <errno.h>
#include <getopt.h>
#include <libintl.h>
#include <limits.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/apparmor.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define _(s) gettext(s)

static const char *opt_lsm = NULL;
static bool opt_debug = false;
static bool opt_verbose = false;
static pid_t pid = 0;

static void usage(const char *name, bool error)
{
	FILE *stream = stdout;
	int status = EXIT_SUCCESS;

	if (error) {
		stream = stderr;
		status = EXIT_FAILURE;
	}

	fprintf(stream,
		_("USAGE: %s [OPTIONS] <prog> <args>\n"
		"\n"
		"Set <prog> to have the specified display LSM.\n"
		"\n"
		"OPTIONS:\n"
		"  -l lsm, --lsm=LSM		LSM that should be displayed\n"
		"  -d, --debug			show messages with debugging information\n"
		"  -v, --verbose       		show messages with stats\n"
		"  -h, --help			display this help\n"
		"\n"), name);
	exit(status);
}

#define error(fmt, args...) _error(_("[%ld] lsm-exec: ERROR: " fmt "\n"), (long)pid, ## args)
static void _error(const char *fmt, ...)
{
	va_list args;

	va_start(args, fmt);
	vfprintf(stderr, fmt, args);
	va_end(args);
	exit(EXIT_FAILURE);
}

#define debug(fmt, args...) _debug(_("[%ld] lsm-exec: DEBUG: " fmt "\n"), (long)pid, ## args)
static void _debug(const char *fmt, ...)
{
	va_list args;

	if (!opt_debug)
		return;

	va_start(args, fmt);
	vfprintf(stderr, fmt, args);
	va_end(args);
}

#define verbose(fmt, args...) _verbose(_("[%ld] " fmt "\n"), (long)pid, ## args)
static void _verbose(const char *fmt, ...)
{
	va_list args;

	if (!opt_verbose)
		return;

	va_start(args, fmt);
	vfprintf(stderr, fmt, args);
	va_end(args);
}

static void verbose_print_argv(char **argv)
{
	if (!opt_verbose)
		return;

	fprintf(stderr, _("[%ld] exec"), (long)pid);
	for (; *argv; argv++)
		fprintf(stderr, " %s", *argv);
	fprintf(stderr, "\n");
}

static char **parse_args(int argc, char **argv)
{
	int opt;
	struct option long_opts[] = {
		{"debug", no_argument, 0, 'd'},
		{"help", no_argument, 0, 'h'},
		{"lsm", required_argument, 0, 'l'},
		{"verbose", no_argument, 0, 'v'},
	};

	while ((opt = getopt_long(argc, argv, "+dhl:v", long_opts, NULL)) != -1) {
		switch (opt) {
		case 'd':
			opt_debug = true;
			break;
		case 'h':
			usage(argv[0], false);
			break;
		case 'l':
			opt_lsm = optarg;
			break;
		case 'v':
			opt_verbose = true;
			break;
		default:
			usage(argv[0], true);
			break;
		}
	}

	if (optind >= argc)
		usage(argv[0], true);

	return argv + optind;
}

static void print_display_lsm(const char *msg)
{
	char buffer[PATH_MAX];
	int fd = -1;
	int size;

	if (!opt_verbose)
		return;

	fd = open("/proc/self/attr/display", O_RDONLY);
	if (fd == -1)
		error("could not open display lsm");
	size = read(fd, buffer, sizeof(buffer)-1);
	if (size == -1)
		error("could not read display lsm");
	buffer[size] = 0;
	verbose("%s: '%s'", msg, buffer);

	close(fd);
}

int main(int argc, char **argv)
{
	char name[PATH_MAX];
	int rc = 0;

	/* IMPORTANT: pid must be initialized before doing anything else since
	 * it is used in a global context when printing messages
	 */
	pid = getpid();

	argv = parse_args(argc, argv);

	print_display_lsm("display lsm before");
	if (opt_lsm) {
		int fd, size;
		fd = open("/proc/self/attr/display", O_CLOEXEC | O_WRONLY);
		if (fd == -1)
			error("could not open /proc/self/attr/display");
		size = write(fd, opt_lsm, strlen(opt_lsm));
		close(fd);
		if (size == -1)
			error("failed write to /proc/self/attr/display");
		else if (size != strlen(opt_lsm))
			error("failed write to /proc/self/attr/display, size %d  != %d", size, strlen(opt_lsm));
		print_display_lsm("display lsm after");
	}

	verbose_print_argv(argv);
	execvp(argv[0], argv);
	error("Failed to execute \"%s\": %m", argv[0]);
}

--------------F255C21D91D810D00E37E9FC--
