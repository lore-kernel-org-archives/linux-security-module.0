From: jannh@google.com (Jann Horn)
Date: Sat, 25 Aug 2018 01:17:37 +0200
Subject: [PATCH v4 3/5] LSM: Security module checking for side-channel
	dangers
In-Reply-To: <20180824224117.3356-4-casey.schaufler@intel.com>
References: <20180824224117.3356-1-casey.schaufler@intel.com>
	<20180824224117.3356-4-casey.schaufler@intel.com>
Message-ID: <CAG48ez0jY6xV+nQdYRy4aT3oH+8FwAM_6MOVFQ3jwYe4Nz+KnA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Aug 25, 2018 at 12:42 AM Casey Schaufler
<casey.schaufler@intel.com> wrote:
> +config SECURITY_SIDECHANNEL_CAPABILITIES
> +       bool "Sidechannel check on capability sets"
> +       depends on SECURITY_SIDECHANNEL
> +       depends on !SECURITY_SIDECHANNEL_ALWAYS
> +       default n
> +       select SECURITY_SIDECHANNEL_NAMESPACES if USER_NS
> +       help
> +         Assume that tasks with different sets of privilege may be
> +         subject to side-channel attacks. Potential interactions
> +         where the attacker lacks capabilities the attacked has
> +         are blocked. Selecting this when user namespaces (USER_NS)
> +         are enabled will enable SECURITY_SIDECHANNEL_NAMESPACES.

Thanks!
