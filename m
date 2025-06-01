Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F279C0;
	Sun,  1 Jun 2025 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748748628; cv=none; b=JNNqHCN//U58k6TbX2UbhHGzpXMFs5Ed5CB/RkAPXSyc6SfMuOExI0wF/AJzwQOZN+sFnxJ80HJB/NmRmAYwCdVOU4mmRuA4mjP0/xvmCRNnT1Uv0FjMGxyvjG9ITThz7Phi78Bw1W3Ncn/BaCBCOqztBmp4qRcyNzlUJr9iQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748748628; c=relaxed/simple;
	bh=cEWEpKaQ4t8kcfW2DjfeskNs8wi6whN1x24yw+xDjCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeaSRLGhUcFomxS0KQQizHBS6Gjm+N3htfloG9M4HVs8pRjyyfdLCc03PbrcId+ZxXihhIwEWgHnccBE9uNz5d4Bi7EiW8GNX85m0FpcuIrLWr/V/Ryz/t5njVu4MBXWWbmnAyEWCbqtYd0f4hTSsimBACSuEpNU/jJjIioBl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ozwolDSH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ozwolDSH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=19UDqAHTr9166dq5eVqV/qBaZTpSvLv9hfDAV+QhXs0=; b=ozwolDSHtM7v0y/Xs+hqcozmG+
	zpwJx0X7jaMA1kop8N1JtSMlxRlmaJ6nm/Gb7nbTAN3QVXd0vV2JVsYHkzbFN3yTNxNcnhxwLvDzN
	BcKdYQQabVeU3+Kd+zn6lKWOTCs2RAVzhGYvQRgjU0rUPagfsf6d2jhZkT0ZShiFJyQ3SfNpJXLeW
	iIhh0mqa3WHvPiQ4mgIxJihMVcAGE8M0IVQ0aQztsqFI386VmYKgwG3kHGqj+0pek0qSI9qH+3vTU
	3MRppM1WDq+ao78bC3VpEI2TIGvQNvFdYfDDRogT5WQzRmHvrQasvcIQZVmZs2AYUgCiE8nHs6aay
	IZay602w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLZOx-0000000HHTW-2NC5;
	Sun, 01 Jun 2025 03:30:23 +0000
Message-ID: <3bb7279f-066a-48df-ac8d-cd8e15120aa2@infradead.org>
Date: Sat, 31 May 2025 20:30:20 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH 2/3] security: add Lilium - Linux Integrity Lock-In User
 Module - Documentation
To: =?UTF-8?B?4oSw8J2Tg/Cdk4/ihLQg4oSx8J2TivCdk4DihK8=?=
 <milesonerd@outlook.com>, "serge@hallyn.com" <serge@hallyn.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <SCYP152MB62612944AD5E282EE26871DDB063A@SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <SCYP152MB62612944AD5E282EE26871DDB063A@SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi--

On 5/31/25 6:07 PM, ℰ𝓃𝓏ℴ ℱ𝓊𝓀ℯ wrote:
> From 23d323f793b888bb2ad0d2a7a1ca095d5d64d0b8 Mon Sep 17 00:00:00 2001
> From: Enzo Fuke <milesonerd@outlook.com>
> Date: Sun, 1 Jun 2025 00:11:36 +0000
> Subject: [PATCH] Lilium Documentation
> 
> ---
>  Documentation/security/lilium.rst | 402 ++++++++++++++++++++++++++++++
>  1 file changed, 402 insertions(+)
>  create mode 100644 Documentation/security/lilium.rst
> 
> diff --git a/Documentation/security/lilium.rst b/Documentation/security/lilium.rst
> new file mode 100644
> index 0000000..bd25ff6
> --- /dev/null
> +++ b/Documentation/security/lilium.rst
> @@ -0,0 +1,402 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +==============================================
> +Lilium (Linux Integrity Lock-In User Module)
> +==============================================
> +
> +:Author: Enzo Fuke
> +:Date: May 2025
> +:Version: 1.0
> +
> +Introduction
> +============
> +
> +Lilium (Linux Integrity Lock-In User Module) is a Linux Security Module (LSM)
> +designed to enhance system security by providing fine-grained control over
> +critical system operations. It implements a modular approach to security,
> +allowing administrators to selectively enable specific security mechanisms
> +based on their requirements.
> +
> +The name "Lilium" is an acronym for "Linux Integrity Lock-In User Module",
> +reflecting its purpose of locking down various system operations to maintain
> +system integrity and security.
> +
> +Security Philosophy
> +------------------

Underline must be at least as long as the heading text.

> +
> +Lilium follows the principle of "secure by default but configurable". All
> +security mechanisms are disabled by default to ensure compatibility with
> +existing systems, but can be easily enabled individually through the sysfs
> +interface. This approach allows administrators to gradually implement security
> +measures without disrupting system functionality.
> +
> +The module is designed with the following principles in mind:
> +
> +1. **Modularity**: Each security mechanism can be enabled independently.
> +2. **Contextual Logic**: Security decisions consider the context of operations.
> +3. **Least Privilege**: Restrictions follow the principle of least privilege.
> +4. **Compatibility**: Works alongside other LSMs in the Linux security stack.
> +
> +Features
> +========
> +
> +Lilium provides the following security mechanisms, each addressing specific
> +security concerns:
> +

[snip]


> +Runtime Configuration
> +--------------------
> +
> +Lilium features can be enabled or disabled at runtime through the sysfs
> +interface. This allows for dynamic configuration without rebooting the system.
> +
> +The sysfs interface is located at `/sys/kernel/lilium/` and provides the
> +following control files:

I think that the path should be `/sys/kernel/security/lilium/` to match the
other LSMs.

Same for below:

> +
> +.. code-block:: bash
> +
> +    # Enable ptrace restrictions
> +    echo 1 > /sys/kernel/lilium/ptrace_enabled
> +
> +    # Disable ptrace restrictions
> +    echo 0 > /sys/kernel/lilium/ptrace_enabled
> +
> +Available sysfs controls:
> +
> +- **/sys/kernel/lilium/ptrace_enabled**: Controls ptrace restrictions
> +- **/sys/kernel/lilium/mprotect_enabled**: Controls mmap/mprotect restrictions
> +- **/sys/kernel/lilium/kexec_enabled**: Controls kexec_load restrictions
> +- **/sys/kernel/lilium/clone_enabled**: Controls clone/unshare restrictions
> +- **/sys/kernel/lilium/module_enabled**: Controls module management restrictions
> +- **/sys/kernel/lilium/open_enabled**: Controls file open restrictions
> +- **/sys/kernel/lilium/ioctl_enabled**: Controls ioctl restrictions
> +
> +Each control file accepts the following values:
> +
> +- **0**: Disable the feature (default)
> +- **1**: Enable the feature

[snip]

> +Implementation Details
> +=====================
> +
> +Hook Registration
> +----------------
> +
> +Lilium registers security hooks for various kernel operations using the LSM
> +framework. These hooks are called by the kernel before performing the
> +corresponding operations, allowing Lilium to make security decisions.
> +
> +The hooks are registered in the `lilium_init` function using the
> +`security_add_hooks` function provided by the LSM framework.
> +
> +Security Decision Logic
> +----------------------

Underline needs to be longer...

Did you 'make htmldocs' to test this?

> +
> +Lilium implements contextual logic for each security hook to determine whether
> +an operation should be allowed or denied. The decision logic follows these
> +general principles:

[snip]

> +Troubleshooting
> +==============

Longer underline...

> +
> +Common Issues
> +------------

ditto.

> +
> +1. **Operation Denied Unexpectedly**
> +
> +   If an operation is denied unexpectedly, check which Lilium features are
> +   enabled:
> +
> +   .. code-block:: bash
> +
> +       cat /sys/kernel/lilium/*/
> +
> +   Disable the relevant feature temporarily to confirm if Lilium is causing
> +   the issue:
> +
> +   .. code-block:: bash
> +
> +       echo 0 > /sys/kernel/lilium/feature_enabled
> +
> +2. **Lilium Not Appearing in sysfs**
> +
> +   If the Lilium sysfs interface is not available, check if Lilium is enabled
> +   in the kernel:
> +
> +   .. code-block:: bash
> +
> +       cat /proc/cmdline | grep lsm
> +
> +   Ensure that "lilium" is included in the lsm parameter.
> +
> +3. **Conflicts with Other Security Modules**
> +
> +   If you experience conflicts with other security modules, check the kernel
> +   log for any error messages:
> +
> +   .. code-block:: bash
> +
> +       dmesg | grep lilium
> +
> +Debugging
> +--------

ditto.

> +
> +Lilium logs important events and errors to the kernel log. You can view these
> +messages using dmesg:
> +
> +.. code-block:: bash
> +
> +    dmesg | grep lilium
> +
> +For more detailed debugging, you can enable kernel debug options for LSMs
> +during kernel compilation.
> +
> +Security Considerations
> +======================

ditto.

> +
> +While Lilium provides additional security controls, it should be considered
> +as part of a defense-in-depth strategy, not a complete security solution.
> +
> +Best Practices
> +-------------

ditto.

> +
> +1. **Start with Minimal Restrictions**: Enable only the features you need to
> +   minimize potential compatibility issues.
> +
> +2. **Test Thoroughly**: Test your configuration in a non-production environment
> +   before deploying to production.
> +
> +3. **Combine with Other Security Measures**: Use Lilium alongside other security
> +   measures like SELinux, AppArmor, seccomp, and regular system updates.
> +
> +4. **Monitor System Logs**: Regularly monitor system logs for any security
> +   events or denied operations.
> +
> +5. **Keep Documentation**: Document your security configuration for future
> +   reference and auditing purposes.
> +
> +Limitations
> +----------
> +
> +1. Lilium cannot protect against all types of attacks or vulnerabilities.
> +
> +2. Some applications may not function correctly with certain restrictions
> +   enabled.
> +
> +3. Lilium operates at the kernel level and cannot protect against user-level
> +   threats without appropriate configuration.
> +
> +Future Development
> +=================

ditto.

> +
> +Planned Features
> +---------------

ditto.

> +
> +1. **Enhanced Logging**: More detailed logging of security events and decisions.
> +
> +2. **Fine-grained Controls**: More granular control over security restrictions.
> +
> +3. **Policy Language**: A simple policy language for configuring Lilium.
> +
> +4. **Integration with Audit**: Better integration with the Linux audit system.
> +
> +Contributing
> +-----------

ditto.

> +
> +Contributions to Lilium are welcome. Please follow the standard Linux kernel
> +development process for submitting patches.


-- 
~Randy

