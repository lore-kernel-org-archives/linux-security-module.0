From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 09:26:52 -0600
Subject: [PATCH v4 04/26] docs: fix broken references with multiple hints
In-Reply-To: <75c14f6d84eef8c10787e85ddc172afebee116d6.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
	<75c14f6d84eef8c10787e85ddc172afebee116d6.1529079119.git.mchehab+samsung@kernel.org>
Message-ID: <20180620152652.GA12591@rob-hp-laptop>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 15, 2018 at 01:30:32PM -0300, Mauro Carvalho Chehab wrote:
> The script:
> 	./scripts/documentation-file-ref-check --fix
> 
> Gives multiple hints for broken references on some files.
> Manually use the one that applies for some files.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/ABI/obsolete/sysfs-gpio                     | 2 +-
>  .../devicetree/bindings/display/bridge/tda998x.txt        | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/trace/events.rst                            | 2 +-
>  Documentation/trace/tracepoint-analysis.rst               | 2 +-
>  Documentation/translations/zh_CN/SubmittingDrivers        | 2 +-
>  Documentation/translations/zh_CN/gpio.txt                 | 4 ++--
>  MAINTAINERS                                               | 2 +-
>  drivers/hid/usbhid/Kconfig                                | 2 +-
>  drivers/input/Kconfig                                     | 4 ++--
>  drivers/input/joystick/Kconfig                            | 4 ++--
>  drivers/input/joystick/iforce/Kconfig                     | 4 ++--
>  drivers/input/serio/Kconfig                               | 4 ++--
>  drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt           | 2 +-
>  drivers/video/fbdev/skeletonfb.c                          | 8 ++++----
>  include/linux/tracepoint.h                                | 2 +-
>  security/device_cgroup.c                                  | 2 +-
>  16 files changed, 24 insertions(+), 24 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
